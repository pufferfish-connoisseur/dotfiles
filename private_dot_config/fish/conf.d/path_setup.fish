if status is-interactive && not set -q GUIX_ENVIRONMENT && not set -q IN_NIX_SHELL
    fish_add_path -P -p ~/.config/emacs/bin
    fish_add_path -P -p ~/.local/bin
    fish_add_path -P -p ~/.nix-profile/bin
    fish_add_path -P -p ~/.guix-profile/bin
    fish_add_path -P -p ~/.config/guix/current/bin

end

if test "$(uname)" = Darwin -a -x /opt/homebrew/bin/brew
    eval $(/opt/homebrew/bin/brew shellenv fish)
end
