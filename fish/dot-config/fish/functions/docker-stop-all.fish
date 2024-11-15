function docker-stop-all
    docker stop $(docker ps -q)
end
