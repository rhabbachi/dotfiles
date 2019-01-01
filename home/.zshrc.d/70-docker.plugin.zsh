#https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
function docker-rmdangling-img() {
  docker rmi $(docker images -f dangling=true -q)
}

function docker-rmexited() {
  docker rm $(docker ps -a -f status=exited -q)
}

function docker-rmdangling-vlm() {
  docker volume rm $(docker volume ls -f dangling=true -q)
}
