function fish_prompt
    set -l last_status $status

    # SSH indicator
    if set -q SSH_CONNECTION; or set -q SSH_TTY; or set -q SSH_CLIENT
        set_color -o yellow
        echo -n "["(hostname -s)"] "
        set_color normal
    end

    # Status icon
    if test $last_status -eq 0
        echo -n "❄️ "
    else
        echo -n "👾 "
    end

    # Adaptive path based on terminal width
    set -l cols $COLUMNS
    set -l path $PWD

    if test $cols -lt 60
        # Very narrow: just the last directory name
        set path (basename $PWD)
    else if test $cols -lt 100
        # Medium: shorten to ~/r/w/subdir style
        set path (prompt_pwd --full-length-dirs 1 --dir-length 1)
    else
        # Wide: show full path but use ~ for home
        set path (string replace -r "^$HOME" "~" $PWD)
    end

    set_color cyan
    echo -n $path
    set_color normal
    echo -n " > "
end
