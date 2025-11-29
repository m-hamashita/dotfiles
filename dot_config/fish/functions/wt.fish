# ref: https://github.com/hiroppy/dotfiles/blob/a062f91732701f0d4cdeac11a0189d083e36c3d2/config/fish/functions/wt.fish
function wt
    set -l cmd $argv[1]

    if test -z "$cmd"
        # Show worktree list with fzf
        set -l selected (git worktree list | fzf \
            --preview-window="right:70%:wrap" \
            --preview='
                set -l worktree_path (echo {} | awk "{print \$1}" 2>/dev/null)
                set -l branch (echo {} | sed "s/.*\[//" | sed "s/\]//" 2>/dev/null)

                echo "=================================================="
                echo "Branch: $branch"
                echo "=================================================="
                echo ""
                echo "Path: $worktree_path"
                echo ""
                echo "Changed files:"
                echo "---------------------------------------------------"
                set -l changes (git -C "$worktree_path" status --porcelain 2>/dev/null)
                if test -z "$changes"
                    echo "  Working tree clean"
                else
                    echo "$changes" | head -10 | while read -l line
                        set -l file_status (echo "$line" | cut -c1-2)
                        set -l file_name (echo "$line" | cut -c4-)
                        switch "$file_status"
                            case "M *"
                                echo "  Modified: $file_name"
                            case "A *"
                                echo "  Added: $file_name"
                            case "D *"
                                echo "  Deleted: $file_name"
                            case "??*"
                                echo "  Untracked: $file_name"
                            case "*"
                                echo "  $line"
                        end
                    end
                end
                echo ""
                echo "Recent commits:"
                echo "---------------------------------------------------"
                git -C "$worktree_path" log --oneline --color=always -10 2>/dev/null | sed "s/^/  /" | bat --language=git-log --style=plain --color=always 2>/dev/null || git -C "$worktree_path" log --oneline --color=always -10 2>/dev/null | sed "s/^/  /"
            ' \
            --header="Git Worktree Manager | Press Enter to navigate" \
            --border \
            --height=80% \
            --layout=reverse | awk '{print $1}'
        )

        if test -n "$selected"
            cd $selected
        end

    else if test "$cmd" = "add"
        set -l branch_name $argv[2]

        if test -z "$branch_name"
            echo "Usage: wt add <branch_name>"
            return 1
        end

        # Get git directory
        set -l git_dir (git rev-parse --git-dir 2>/dev/null)
        if test -z "$git_dir"
            echo "Not in a git repository"
            return 1
        end

        # Create tmp_worktrees directory if it doesn't exist
        set -l tmp_worktrees_dir "$git_dir/tmp_worktrees"
        if not test -d "$tmp_worktrees_dir"
            mkdir -p "$tmp_worktrees_dir"
        end

        # Generate directory name with timestamp
        set -l timestamp (date +"%Y%m%d_%H%M%S")
        set -l dir_name "$timestamp"_"$branch_name"
        set -l worktree_path "$tmp_worktrees_dir/$dir_name"

        # Create new branch and worktree
        git worktree add -b "$branch_name" "$worktree_path"

        if test $status -eq 0
            echo "Created worktree at: $worktree_path"
            echo "Branch: $branch_name"

            # Store project root before changing directory
            set -l project_root (git rev-parse --show-toplevel)

            cd "$worktree_path"

            # Execute .wt_hook.fish if it exists in the project root
            if test -f "$project_root/.wt_hook.fish"
                echo "Executing .wt_hook.fish..."
                set -gx WT_WORKTREE_PATH "$worktree_path"
                set -gx WT_BRANCH_NAME "$branch_name"
                set -gx WT_PROJECT_ROOT "$project_root"
                source "$project_root/.wt_hook.fish"
                set -e WT_WORKTREE_PATH
                set -e WT_BRANCH_NAME
                set -e WT_PROJECT_ROOT
            end
        end

    else if test "$cmd" = "remove"
        set -l branch_name $argv[2]

        if test -z "$branch_name"
            echo "Usage: wt remove <branch_name>"
            return 1
        end

        # Find worktree path by branch name
        set -l worktree_info (git worktree list | grep "\[$branch_name\]")

        if test -z "$worktree_info"
            echo "No worktree found for branch: $branch_name"
            return 1
        end

        set -l worktree_path (echo $worktree_info | awk '{print $1}')

        # Remove worktree
        git worktree remove --force "$worktree_path"

        if test $status -eq 0
            # Delete branch
            git branch -D "$branch_name"
            echo "Removed worktree and branch: $branch_name"
        end

    else if test "$cmd" = "init"
        # Check if .wt_hook.fish already exists
        if test -f ".wt_hook.fish"
            echo ".wt_hook.fish already exists"
            return 1
        end

        # Create .wt_hook.fish with copy template
        printf "%s\n" "\
# .wt_hook.fish - Executed after 'wt add' command in worktree directory
# Available variables:
# - \$WT_WORKTREE_PATH: Path to the new worktree (current directory)
# - \$WT_BRANCH_NAME: Name of the branch
# - \$WT_PROJECT_ROOT: Path to the original project root

# ===============================================
# Copy root-level items from project → worktree (no find)
# ===============================================

set root_copy_items \".claude\" \".agent\" \".kiro\" \".vscode\"

for item in \$root_copy_items
    if test -f \"\$WT_PROJECT_ROOT/\$item\"
        cp \"\$WT_PROJECT_ROOT/\$item\" \"\$item\"
        echo \"Copied file \$item to worktree\"
    else if test -d \"\$WT_PROJECT_ROOT/\$item\"
        cp -RP \"\$WT_PROJECT_ROOT/\$item\" \"\$item\"
        echo \"Copied directory \$item to worktree\"
    end
end

# ===============================================
# Find & copy config-like files (e.g. .env) from project → worktree
# ===============================================

# Targets searched recursively via find
set find_copy_files \".env\"

echo \"Scanning for recursive copy files under: \$WT_PROJECT_ROOT (targets: \$find_copy_files)\"

set -l find_sources

for name in \$find_copy_files
    set find_sources \$find_sources (find \"\$WT_PROJECT_ROOT\" -name \"\$name\" -not -path \"*/.git/*\" 2>/dev/null)
end

if test (count \$find_sources) -eq 0
    echo \"No recursive copy file targets found.\"
else
    set -l root_pattern_find (string escape --style=regex \"\$WT_PROJECT_ROOT/\")

    for src in \$find_sources
        set -l rel_path (string replace -r \"^\$root_pattern_find\" \"\" \"\$src\")

        if test \"\$rel_path\" = \"\$src\"
            echo \"WARN(find): could not compute relative path for \$src\"
            continue
        end

        set -l dest \"\$rel_path\"
        set -l dest_parent (path dirname \"\$dest\")
        mkdir -p \"\$dest_parent\"

        if test -e \"\$dest\"
            echo \"Skip(find): \$dest already exists\"
        else
            echo \"Copying file: \$src -> \$dest\"
            cp \"\$src\" \"\$dest\"
        end
    end
end

# ===============================================
# Find & copy all .venv directories from project → worktree
# ===============================================

echo \"Scanning for .venv directories under: \$WT_PROJECT_ROOT\"

set -l venv_dirs (find \"\$WT_PROJECT_ROOT\" -type d -name \".venv\" -not -path \"*/.git/*\" 2>/dev/null)

if test (count \$venv_dirs) -eq 0
    echo \"No .venv directories found.\"
else
    set -l root_pattern_venv (string escape --style=regex \"\$WT_PROJECT_ROOT/\")

    for venv_src in \$venv_dirs
        set -l rel_path (string replace -r \"^\$root_pattern_venv\" \"\" \"\$venv_src\")

        if test \"\$rel_path\" = \"\$venv_src\"
            echo \"WARN(venv): could not compute relative path for \$venv_src\"
            continue
        end

        set -l venv_dest \"\$rel_path\"

        set -l dest_parent (path dirname \"\$venv_dest\")
        mkdir -p \"\$dest_parent\"

        if test -e \"\$venv_dest\"
            echo \"Skip(venv): \$venv_dest already exists\"
        else
            echo \"Copying .venv: \$venv_src -> \$venv_dest\"
            cp -RP \"\$venv_src\" \"\$venv_dest\"
        end
    end
end
" > .wt_hook.fish

        echo "Created .wt_hook.fish template"
    else if test "$cmd" = "help"
        echo "Usage:"
        echo "  wt                 - Show worktree list with fzf"
        echo "  wt add <branch>    - Create new branch and worktree"
        echo "  wt remove <branch> - Remove worktree and branch"
        echo "  wt init            - Create .wt_hook.fish template"
        echo "  wt help            - Show this help message"
    else
        echo "Unknown command: $cmd"
        echo "Usage:"
        echo "  wt                 - Show worktree list with fzf"
        echo "  wt add <branch>    - Create new branch and worktree"
        echo "  wt remove <branch> - Remove worktree and branch"
        echo "  wt init            - Create .wt_hook.fish template"
        echo "  wt help            - Show this help message"
        return 1
    end
end
