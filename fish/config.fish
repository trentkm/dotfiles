if status is-interactive
    set -gx EDITOR nvim
    set -gx AGMUX_THEME light
end
export PATH="$HOME/.local/bin:$PATH"
abbr -a ssh-mini 'ssh trent@192.168.86.25'
abbr -a lg lazygit

function theme
    set -l mode $argv[1]
    if test -z "$mode"
        echo "Usage: theme light|dark"
        return 1
    end

    set -l ghostty_config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    set -l tmux_conf (readlink "$HOME/.tmux.conf" || echo "$HOME/.tmux.conf")
    set -l yazi_theme "$HOME/.config/yazi/theme.toml"
    set -l lazygit_config "$HOME/Library/Application Support/lazygit/config.yml"

    if test "$mode" = light
        # Ghostty
        sed -i '' 's/^theme = .*/theme = Breadog/' "$ghostty_config"
        # Tmux
        sed -i '' 's/^set -g status-style .*/set -g status-style '\''bg=#f1ebe6 fg=#baa99d'\''/' "$tmux_conf"
        sed -i '' 's/^set -g status-left .*/set -g status-left '\''#[fg=#362c24,bold] #{session_name} #[default]'\''/' "$tmux_conf"
        sed -i '' "s/^set -g status-right .*/set -g status-right '#(agmux status) #[fg=#baa99d]%H:%M#[default] '/" "$tmux_conf"
        sed -i '' 's/^setw -g window-status-format .*/setw -g window-status-format '\''#[fg=#baa99d] ○ '\''/' "$tmux_conf"
        sed -i '' 's/^setw -g window-status-current-format .*/setw -g window-status-current-format '\''#[fg=#362c24,bold] ● '\''/' "$tmux_conf"
        sed -i '' 's/^set -g window-style .*/set -g window-style '\''fg=#baa99d,bg=#eae1da'\''/' "$tmux_conf"
        sed -i '' 's/^set -g pane-border-style .*/set -g pane-border-style '\''fg=#baa99d'\''/' "$tmux_conf"
        sed -i '' 's/^set -g pane-active-border-style .*/set -g pane-active-border-style '\''fg=#006a78'\''/' "$tmux_conf"
        sed -i '' "s/^set -g pane-border-format .*/set -g pane-border-format ' #[fg=#006a78]#{?pane_active,● ,}#[default]#{pane_current_command} '/" "$tmux_conf"
        sed -i '' 's/^set-environment -g AGMUX_THEME .*/set-environment -g AGMUX_THEME light/' "$tmux_conf"
        # Yazi
        printf '[flavor]\nlight = "breadog"\ndark = "breadog"\n' > "$yazi_theme"
        # Lazygit
        printf 'gui:\n  theme:\n    selectedLineBgColor:\n      - "#eae1da"\n    selectedRangeBgColor:\n      - "#eae1da"\n' > "$lazygit_config"
        # Env
        set -gx AGMUX_THEME light
        tmux set-environment -g AGMUX_THEME light 2>/dev/null

    else if test "$mode" = dark
        # Ghostty
        sed -i '' 's/^theme = .*/theme = Desert/' "$ghostty_config"
        # Tmux
        sed -i '' 's/^set -g status-style .*/set -g status-style '\''bg=#333333 fg=#626262'\''/' "$tmux_conf"
        sed -i '' 's/^set -g status-left .*/set -g status-left '\''#[fg=#f5deb3,bold] #{session_name} #[default]'\''/' "$tmux_conf"
        sed -i '' "s/^set -g status-right .*/set -g status-right '#(agmux status) #[fg=#626262]%H:%M#[default] '/" "$tmux_conf"
        sed -i '' 's/^setw -g window-status-format .*/setw -g window-status-format '\''#[fg=#626262] ○ '\''/' "$tmux_conf"
        sed -i '' 's/^setw -g window-status-current-format .*/setw -g window-status-current-format '\''#[fg=#f5deb3,bold] ● '\''/' "$tmux_conf"
        sed -i '' 's/^set -g window-style .*/set -g window-style '\''fg=#626262,bg=#2a2a2a'\''/' "$tmux_conf"
        sed -i '' 's/^set -g pane-border-style .*/set -g pane-border-style '\''fg=#4d4d4d'\''/' "$tmux_conf"
        sed -i '' 's/^set -g pane-active-border-style .*/set -g pane-active-border-style '\''fg=#cd853f'\''/' "$tmux_conf"
        sed -i '' "s/^set -g pane-border-format .*/set -g pane-border-format ' #[fg=#cd853f]#{?pane_active,● ,}#[default]#{pane_current_command} '/" "$tmux_conf"
        sed -i '' 's/^set-environment -g AGMUX_THEME .*/set-environment -g AGMUX_THEME dark/' "$tmux_conf"
        # Yazi
        printf '[flavor]\nlight = "desert"\ndark = "desert"\n' > "$yazi_theme"
        # Lazygit
        printf 'gui:\n  theme:\n    selectedLineBgColor:\n      - "#4d4d4d"\n    selectedRangeBgColor:\n      - "#4d4d4d"\n' > "$lazygit_config"
        # Env
        set -gx AGMUX_THEME dark
        tmux set-environment -g AGMUX_THEME dark 2>/dev/null
    end

    # Reload tmux
    tmux source-file "$tmux_conf" 2>/dev/null
    echo "Switched to $mode mode. Reload Ghostty with Cmd+Shift+,"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
