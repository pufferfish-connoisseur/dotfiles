set -p PATH ~/.config/emacs/bin
set -p PATH ~/.local/bin

if test "$(uname)" = "Darwin" -a -x /opt/homebrew/bin/brew
    eval $(/opt/homebrew/bin/brew shellenv fish)
end
