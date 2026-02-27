function fish_prompt
    if test $status -eq 0
        set_color normal
        echo -n "❄️ "
    else
        set_color normal
        echo -n "👾 "
    end
    set_color cyan
    echo -n $PWD
    set_color normal
    echo -n " > "
end
