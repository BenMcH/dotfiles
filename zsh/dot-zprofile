if [ -z "$SSH_AGENT_PID" ]; then
    eval "$(ssh-agent -s)"
fi

if [ -z "$(ssh-add -L)" ]; then
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ed25519
fi

