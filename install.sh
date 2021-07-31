#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="daapd"
VERSION="202107311147-git"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#set opts

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202107311147-git
# @Author        : casjay
# @Contact       : casjay
# @License       : WTFPL
# @ReadME        : dockermgr --help
# @Copyright     : Copyright: (c) 2021 casjay, casjay
# @Created       : Saturday, Jul 31, 2021 11:47 EDT
# @File          : daapd
# @Description   : daapd docker container installer
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import functions
CASJAYSDEVDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}/functions"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-testing.bash}"
SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/dfmgr/installer/raw/$GIT_DEFAULT_BRANCH/functions}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$PWD/$SCRIPTSFUNCTFILE" ]; then
  . "$PWD/$SCRIPTSFUNCTFILE"
elif [ -f "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE"
else
  echo "Can not load the functions file: $SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" 1>&2
  exit 1
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# user system devenv dfmgr dockermgr fontmgr iconmgr pkmgr systemmgr thememgr wallpapermgr
dockermgr_install
__options "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Begin installer
APPNAME="daapd"
DOCKER_HUB_URL="linuxserver/daapd"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPDIR="${APPDIR:-/usr/local/share/CasjaysDev/$SCRIPTS_PREFIX/$APPNAME}"
INSTDIR="${INSTDIR:-/usr/local/share/CasjaysDev/$SCRIPTS_PREFIX/$APPNAME}"
DATADIR="${DATADIR:-/srv/docker/$APPNAME}"
REPORAW="$REPO/raw/$GIT_DEFAULT_BRANCH"
APPVERSION="$(__appversion "$REPORAW/version.txt")"
TIMEZONE="${TZ:-$TIMEZONE}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
sudo mkdir -p "$DATADIR"/{data,config}
sudo chmod -Rf 777 "$DATADIR"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$INSTDIR/docker-compose.yml" ]; then
  cd "$INSTDIR" && docker-compose up -d
else
  if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
    sudo docker pull "$DOCKER_HUB_URL"
    sudo docker restart "$APPNAME"
  else
    sudo docker run -d \
      --name "$APPNAME" \
      --hostname "$APPNAME" \
      --net=host \
      -e TZ=${TIMEZONE:-America/New_York} \
      -v "$DATADIR/config":/config \
      -v "$DATADIR/music":/music \
      "$DOCKER_HUB_URL"
  fi
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if docker ps -a | grep "$APPNAME" >/dev/null 2>&1; then
  printf_green "Successfully setup daapd"
else
  printf_return "Could not setup daapd"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End script
exit $?
