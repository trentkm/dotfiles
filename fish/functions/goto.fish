function goto
    if test (count $argv) -eq 0
        # No argument - go to repos root
        cd ~/repos
    else
        # Try to find matching directory
        set project_path ~/repos/$argv[1]
        if test -d $project_path
            cd $project_path
        else
            echo "Project '$argv[1]' not found in ~/repos"
            return 1
        end
    end
end
