function gho --description "Open trentkm/<dir basename> GitHub repo in browser"
    set -l target $argv[1]
    if test -z "$target"
        set target .
    end

    if not command -q gh
        echo "gh CLI not found; install https://cli.github.com/ or add to PATH" >&2
        return 1
    end

    set -l dir (path resolve $target 2>/dev/null)
    if test $status -ne 0
        echo "gho: unable to resolve path '$target'" >&2
        return 1
    end

    set -l name (path basename $dir)
    if test -z "$name"
        echo "gho: empty repository name" >&2
        return 1
    end

    gh repo view trentkm/$name --web
end
