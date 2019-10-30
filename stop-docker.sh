docker stop $(docker ps -a -q)
# docker rm -v $(docker ps -a -q)
docker rm -f -v $(docker ps -aq)
