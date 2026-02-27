function cpt --description "Copy path to clipboard. No args = cwd, or pass a file/dir"
    if test (count $argv) -eq 0
        pwd | pbcopy
        echo "Copied: "(pwd)
    else
        set -l p (path resolve $argv[1] 2>/dev/null)
        if test $status -ne 0 -o -z "$p"
            echo "cpt: unable to resolve '$argv[1]'" >&2
            return 1
        end
        echo -n $p | pbcopy
        echo "Copied: $p"
    end
end
