if command -q eza
  abbr -a ls eza
  abbr -a la eza -al
  abbr -a ll eza -l
  abbr -a lt eza -TL 2
end

abbr -a fuckemacs pkill -SIGUSR2 emacs
