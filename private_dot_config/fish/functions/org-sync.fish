function org-sync --description 'Bidirectional sync of ~/org with orgvault:orgvault (rclone bisync)'
    if not type -q rclone
        echo "org-sync: rclone is not installed or not on PATH." >&2
        return 127
    end

    command rclone bisync -P ~/org orgvault:orgvault $argv
end
