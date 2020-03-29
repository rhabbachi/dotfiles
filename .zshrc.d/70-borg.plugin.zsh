function borg_home_backup() {
  BORG_RSH="ssh -i /home/rhabbachi/.ssh/rhabbachi -p 5022" borg create -ps --exclude-caches --exclude-from ~/.attic/ignorelist borg@borg.haropi.lan:/backups/banshee.borg::$(date +%Y%m%d-%H%M%S) /home/rhabbachi
}

function borg_home_check() {
  BORG_RSH="ssh -i /home/rhabbachi/.ssh/rhabbachi -p 5022" borg check --verbose borg@borg.haropi.lan:/backups/banshee.borg
}
