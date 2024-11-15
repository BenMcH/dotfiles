function docker-clean
    docker-stop-all

    docker rm $(docker ps -aq)
end
