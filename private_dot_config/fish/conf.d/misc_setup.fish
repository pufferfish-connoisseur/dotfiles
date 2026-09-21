if status is-interactive
  set SHELL (status fish-path)
end

if test -n "$GHOSTTY_RESOURCES_DIR"
  builtin source {$GHOSTTY_RESOURCES_DIR}/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
end

if set -q LS_COLORS
    set -e LS_COLORS
end

if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end
