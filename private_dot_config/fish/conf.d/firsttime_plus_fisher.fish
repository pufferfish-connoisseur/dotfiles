set -g fisher_path $__fish_config_dir/fisher

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# First time setup goes here to guarentee order

if not set -q __alreadyConfigured

    set -U __alreadyConfigured
    fish_config theme save catppuccin
    set -l temp_fisher_path $HOME/.config/fish/fisher/functions/fisher.fish
    if not test -f $temp_fisher_path
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
    end
    fish_hybrid_key_bindings
    set -e temp_fisher_path
end
