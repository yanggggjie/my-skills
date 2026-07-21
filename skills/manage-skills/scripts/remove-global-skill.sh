#!/usr/bin/env bash
# 彻底卸载全局 skill：对 ls 仍列出的每个 agent 调用 skills remove，再清残留目录/symlink。
# 用法：remove-global-skill.sh <skill-name> [<skill-name>...]
#        remove-global-skill.sh --self-check
set -euo pipefail

map_agent() {
  case "$1" in
    "Claude Code"|claude-code) echo claude-code ;;
    Cline|cline) echo cline ;;
    Codex|codex) echo codex ;;
    Cursor|cursor) echo cursor ;;
    "Gemini CLI"|gemini-cli) echo gemini-cli ;;
    "GitHub Copilot"|github-copilot) echo github-copilot ;;
    "Kimi Code CLI"|kimi-code-cli) echo kimi-code-cli ;;
    OpenCode|opencode) echo opencode ;;
    Warp|warp) echo warp ;;
    Universal|universal) echo universal ;;
    *)
      printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[[:space:]]\+/-/g'
      ;;
  esac
}

list_json() {
  npx skills ls -g --json 2>/dev/null
}

skill_agents() {
  local name="$1"
  list_json | python3 -c '
import json,sys
name=sys.argv[1]
items=json.load(sys.stdin)
if isinstance(items, dict):
    items=items.get("skills") or []
for x in items:
    if x.get("name")==name:
        for a in x.get("agents") or []:
            print(a)
        break
' "$name"
}

skill_listed() {
  local name="$1"
  list_json | python3 -c '
import json,sys
name=sys.argv[1]
items=json.load(sys.stdin)
if isinstance(items, dict):
    items=items.get("skills") or []
sys.exit(0 if any(x.get("name")==name for x in items) else 1)
' "$name"
}

# bash 3.2：用空格分隔串做去重
append_unique() {
  # $1 = current list var name via nameref-ish: we echo new list
  local list="$1"
  local item="$2"
  case " $list " in
    *" $item "*) printf '%s' "$list" ;;
    *)
      if [ -z "$list" ]; then printf '%s' "$item"
      else printf '%s' "$list $item"
      fi
      ;;
  esac
}

sweep_residuals() {
  local name="$1"
  local canon="$HOME/.agents/skills/$name"
  local p target
  while IFS= read -r p; do
    [ -z "$p" ] && continue
    case "$p" in
      */.cache/*|*/node_modules/*|*/.gh-repos/*|*/uv/archive/*) continue ;;
    esac
    if [ -L "$p" ]; then
      target=$(readlink "$p" || true)
      case "$target" in
        */.agents/skills/"$name"|*/.agents/skills/"$name"/*|../../.agents/skills/"$name")
          rm -f "$p"
          echo "removed symlink: $p"
          ;;
      esac
    fi
  done < <(find "$HOME" -maxdepth 4 -type l -name "$name" 2>/dev/null || true)

  if [ -e "$canon" ]; then
    rm -rf "$canon"
    echo "removed: $canon"
  fi
}

remove_one() {
  local name="$1"
  local agents="universal claude-code"
  local label id a
  local agent_flags=()
  local left_flags=()

  if ! skill_listed "$name"; then
    sweep_residuals "$name"
    if ! skill_listed "$name" && [ ! -e "$HOME/.agents/skills/$name" ]; then
      echo "ok: $name not installed"
      return 0
    fi
  fi

  while IFS= read -r label; do
    [ -z "$label" ] && continue
    id=$(map_agent "$label")
    [ -z "$id" ] && continue
    agents=$(append_unique "$agents" "$id")
  done < <(skill_agents "$name")

  agent_flags=()
  for a in $agents; do
    agent_flags+=(-a "$a")
  done

  echo "removing $name from: $agents"
  npx skills remove "$name" -g -y "${agent_flags[@]}"

  sweep_residuals "$name"

  if skill_listed "$name" || [ -e "$HOME/.agents/skills/$name" ]; then
    left_flags=()
    while IFS= read -r label; do
      [ -z "$label" ] && continue
      left_flags+=(-a "$(map_agent "$label")")
    done < <(skill_agents "$name")
    if [ "${#left_flags[@]}" -gt 0 ]; then
      npx skills remove "$name" -g -y "${left_flags[@]}"
    fi
    sweep_residuals "$name"
  fi

  if skill_listed "$name" || [ -e "$HOME/.agents/skills/$name" ]; then
    echo "fail: $name still present" >&2
    npx skills ls -g 2>/dev/null | grep -i "$name" || true
    ls -la "$HOME/.agents/skills/$name" 2>&1 || true
    return 1
  fi
  echo "ok: $name removed"
}

self_check() {
  [ "$(map_agent "Claude Code")" = claude-code ]
  [ "$(map_agent "GitHub Copilot")" = github-copilot ]
  list_json | python3 -c "import json,sys; json.load(sys.stdin)"
  # 未安装名应干净退出
  remove_one "__manage_skills_self_check_missing__"
  echo "ok: self-check"
}

if [ "${1:-}" = "--self-check" ]; then
  self_check
  exit 0
fi

if [ "$#" -lt 1 ]; then
  echo "usage: $0 <skill-name> [<skill-name>...]" >&2
  echo "       $0 --self-check" >&2
  exit 2
fi

ec=0
for name in "$@"; do
  remove_one "$name" || ec=1
done
exit "$ec"
