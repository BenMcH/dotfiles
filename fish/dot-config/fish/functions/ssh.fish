function ssh
    if test -z "$SSH_AGENT_PID"
        eval $(ssh-agent -c)
        ssh-add ~/.ssh/id_rsa
        ssh-add ~/.ssh/id_ed25519
    end

    command ssh $argv
end
