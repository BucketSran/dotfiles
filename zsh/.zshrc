export HTTP_PROXY=http://127.0.0.1:7897
export HTTPS_PROXY=http://127.0.0.1:7897
export ALL_PROXY=socks5://127.0.0.1:7897

export PATH="$HOME/bin:$PATH"

# OpenClaw Completion
source "/Users/bucketsran/.openclaw/completions/openclaw.zsh"

# Ghostty launcher helper (brew cask installs the app bundle)
alias ghostty='open -a Ghostty'

# Yazi wrapper: keep shell cwd in sync after quitting yazi
function y() {
	local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r cwd < "$tmp"
	if [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# fzf shell integrations
if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
	source /opt/homebrew/opt/fzf/shell/completion.zsh
fi
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
	source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# zoxide smart-cd
eval "$(zoxide init zsh)"

# zsh plugins: gray history autosuggestions + syntax highlighting
# (brew-installed; must be sourced last, after everything above)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto-activate learn-cc venv when working inside ~/Documents/AILearning.
# Leaves the venv automatically when you cd out. Remove this block to disable.
function _learn_cc_autoenv() {
    local target="$HOME/Documents/AILearning"
    local venv="$HOME/Documents/AILearning/learn-claude-code/.venv"
    local stale_venv="$HOME/Documents/AILearning/.venv"   # the old 3.9 venv we replaced
    if [[ "$PWD" == "$target" || "$PWD" == "$target"/* ]]; then
        # Inside AILearning: if the stale 3.9 venv is somehow active, kick it out first.
        if [[ "$VIRTUAL_ENV" == "$stale_venv" ]]; then
            deactivate 2>/dev/null
        fi
        if [[ -z "$VIRTUAL_ENV" && -f "$venv/bin/activate" ]]; then
            source "$venv/bin/activate"
        fi
    else
        if [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" == "$venv" ]]; then
            deactivate
        fi
    fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _learn_cc_autoenv
_learn_cc_autoenv   # also run once at shell startup for the initial cwd
