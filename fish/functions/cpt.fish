function cpt --description "Copy path to clipboard. No args = cwd, or pass a file/dir"
    if test (count $argv) -eq 0
        pwd | pbcopy
        echo "Copied: "(pwd)
    else
        set -l target $argv[1]
        # Build absolute path without resolving symlinks
        if not string match -q '/*' -- $target
            set target $PWD/$target
        end
        # Clean up trailing slashes
        set target (string replace -r '/+$' '' -- $target)
        if not test -e $target
            echo "cpt: '$argv[1]' does not exist" >&2
            return 1
        end
        echo -n $target | pbcopy
        echo "Copied: $target"
    end
end
