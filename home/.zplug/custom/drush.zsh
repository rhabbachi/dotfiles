alias dr='drush'

function sql2zip() {
command -v drush >/dev/null 2>&1 || { echo >&2 "I require drush but it's not installed.  Aborting."; exit 1; }
command -v atool >/dev/null 2>&1 || { echo >&2 "I require atool but it's not installed.  Aborting."; exit 1; }

local cmd="drush"
local tag=""
local comment=""
local filename=""
local site_alias=""
while getopts "n:a:t:c:h" opt; do
  case "$opt" in
    h)
      echo "Usage: sql2bz -a [site alias] -n [filename] -t [tag] -c [comment]"
      exit
      ;;
    n)
      filename="$OPTARG"
      ;;
    a)
      local site_alias="@$OPTARG"
      [[ -z $filename ]] && filename="$OPTARG"
      ;;
    t)
      tag="$OPTARG"
      ;;
    c)
      comment="$OPTARG"
      ;;
  esac
done

local localfile="$HOME/.drush-dumps/${filename}-`date +%Y%m%d-%H%M%S`-${tag}-${comment}.sql.bz2"
trap "rm -f $localfile" SIGHUP SIGINT SIGTERM
drush $site_alias sqldump | pv -ptrb | atool -a $localfile
}

function zip2sql() {
command -v drush >/dev/null 2>&1 || { echo >&2 "I require drush but it's not installed.  Aborting."; exit 1; }
command -v atool >/dev/null 2>&1 || { echo >&2 "I require lbzip2 but it's not installed.  Aborting."; exit 1; }

trap "exit 1" SIGHUP SIGINT SIGTERM
drush sql-drop -y && atool -c $1 | pv -pterb | drush sqlc
drush updb -y
drush localhost
}
