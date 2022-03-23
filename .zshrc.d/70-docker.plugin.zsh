#https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
function ,docker-prune-vlm() {
  docker volume rm $(docker volume ls -f dangling=true -q)
}

alias ,docker-system-prune="{ docker system prune all ; ,docker-prune-vlm ; }"

function ,ocrmypdf() {
  docker run --rm  -i --user "$(id -u):$(id -g)" --workdir /data -v "$PWD:/data" jbarlow83/ocrmypdf
}
