if status is-interactive
    set -gx EDITOR nvim
    set -gx AGMUX_THEME light
end
export PATH="$HOME/.local/bin:$PATH"
abbr -a ssh-mini 'ssh trent@192.168.86.25'
abbr -a lg lazygit

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
