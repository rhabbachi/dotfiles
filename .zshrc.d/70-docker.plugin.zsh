#https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes
function ,docker-prune-vlm() {
  docker volume rm $(docker volume ls -f dangling=true -q)
}

alias -g ,docker-system-prune="{ docker system prune all ; ,docker-prune-vlm ; }"

alias -g ,ocrmypdf='docker run --rm  -i --user "$(id -u):$(id -g)" --workdir /data -v "$PWD:/data" jbarlow83/ocrmypdf'

function ,ocrmypdf_dir() {
  for file in *.tif; do
    ,ocrmypdf -l fra --rotate-pages --deskew --clean-final --image-dpi 600 "$file" "./ocrmypdf/${file%.tif}.pdf"
  done
}
