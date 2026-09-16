#!/usr/bin/env python3
import json
import os
import re
import subprocess
import sys

SETTINGS_PATH = os.path.expanduser("~/.claude/settings.json")

RESET = "\033[0m"
COLOR_BRANCH = "\033[38;5;109m"   # cyan-blue, matches tmux worktree colour
COLOR_REPO = "\033[38;5;223m"     # warm gold, matches tmux directory colour
COLOR_COST = "\033[38;5;150m"     # green
COLOR_MODEL = "\033[38;5;183m"    # purple
COLOR_EFFORT = "\033[38;5;214m"   # orange
COLOR_SEP = "\033[38;5;240m"      # dim grey
COLOR_OK = "\033[38;5;150m"       # green, usage < 70%
COLOR_WARN = "\033[38;5;214m"     # orange, usage 70-89%
COLOR_CRIT = "\033[38;5;203m"     # red, usage >= 90%

ANSI_RE = re.compile(r"\033\[[0-9;]*m")


def colorize(color, text):
    return f"{color}{text}{RESET}"


def visible_len(text):
    return len(ANSI_RE.sub("", text))


def usage_color(pct):
    if pct >= 90:
        return COLOR_CRIT
    if pct >= 70:
        return COLOR_WARN
    return COLOR_OK


def get_rate_limits_str(data):
    rate_limits = data.get("rate_limits") or {}
    pieces = []
    for key, label in (("five_hour", "5h"), ("seven_day", "7d")):
        pct = (rate_limits.get(key) or {}).get("used_percentage")
        if pct is None:
            continue
        pieces.append(colorize(usage_color(pct), f"{label} {pct:.0f}%"))
    if not pieces:
        return ""
    return colorize(COLOR_SEP, "Limits: ") + " ".join(pieces)


def get_git_branch(cwd):
    try:
        result = subprocess.run(
            ["git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True,
            text=True,
            timeout=1,
        )
        if result.returncode == 0:
            return result.stdout.strip()
    except Exception:
        pass
    return None


def get_effort_level():
    try:
        with open(SETTINGS_PATH) as f:
            settings = json.load(f)
        return settings.get("effortLevel", "default")
    except Exception:
        return "default"


def main():
    data = json.load(sys.stdin)

    workspace = data.get("workspace", {})
    cwd = workspace.get("current_dir") or data.get("cwd") or os.getcwd()
    model = data.get("model", {}).get("display_name", "unknown")
    cost = data.get("cost", {}).get("total_cost_usd", 0.0)

    branch = get_git_branch(cwd)
    effort = get_effort_level()

    repo = os.path.basename(cwd.rstrip("/")) or cwd

    parts = []
    if branch:
        parts.append(colorize(COLOR_BRANCH, branch))
    parts.append(colorize(COLOR_REPO, repo))
    parts.append(colorize(COLOR_COST, f"${cost:.2f}"))
    parts.append(colorize(COLOR_MODEL, model))
    parts.append(colorize(COLOR_EFFORT, f"settings.json effort:{effort}"))

    sep = colorize(COLOR_SEP, " | ")
    left = sep.join(parts)

    right = get_rate_limits_str(data)

    if right:
        try:
            columns = int(os.environ.get("COLUMNS", "0"))
        except ValueError:
            columns = 0

        gap = columns - visible_len(left) - visible_len(right) if columns else 0
        if gap >= 1:
            print(left + " " * gap + right)
        else:
            print(left + sep + right)
    else:
        print(left)


if __name__ == "__main__":
    main()
