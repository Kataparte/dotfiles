# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

#alias setwall='function _setwall() { swww img "$1" && matugen image "$1"; }; _setwall'
alias setwall='function _setwall() { swww img "$1" && matugen image "$(realpath "$1")"; }; _setwall'
export PATH="$HOME/bin:$PATH"

alias dotsync='cd ~/dotfiles && git add . && git commit -m "Manual sync" && git push && cd -'
# --- TROUBLESHOOTING COMMANDS ---
# System Interrupt/Stutter Meter:
alias meter='watch -n 1 "grep '\''^ *9:'\'' /proc/interrupts"'
#alias meter='watch -n 1 "awk '\''/^ *9:/ {for(i=2;i<=NF-2;i++) s+=\$i; print \"Interrupt 9 Activity: \" s-p; p=s}'\'' <(cat /proc/interrupts; sleep 1; cat /proc/interrupts) | tail -n 1"'
alias dots='~/.local/bin/dots'

# Open Hyprland.conf
alias conf='nano ~/.config/hypr/hyprland.conf'

# sourced matrix matugen
[ -f ~/.config/matugen/matrix_alias.sh ] && source ~/.config/matugen/matrix_alias.sh

# Modern Aliases (Icons for ls)
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --grid --group-directories-first'

# History Search (Ctrl+R)
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash

# Starship (The Owl) - Second to last
eval "$(starship init bash)"

# Zoxide (The Teleporter) - MUST BE THE VERY LAST LINE
eval "$(zoxide init bash)"

# Toggle Python Virtual Environment
py() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        echo "🦉 Environment deactivated."
    else
        source ~/school_python/venv/bin/activate
        echo "🐍 Python venv active!"
    fi
}
