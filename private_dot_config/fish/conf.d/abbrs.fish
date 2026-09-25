if status is-interactive
    abbr -a debugemacs pkill -SIGUSR2 emacs
    if test "$(uname)" = Linux
        abbr -a fuckemacs systemctl --user restart emacs
    end
end
