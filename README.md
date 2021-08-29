# Welcome to dockermgr daapd installer 👋
  
### # @Description  
  
#### Requires scripts to be installed

```shell
 sudo bash -c "$(curl -LSs <https://github.com/dockermgr/installer/raw/main/install.sh>)"
 dockermgr --config && dockermgr install scripts  
```

#### Automatic install/update  

```shell
dockermgr install daapd
```


#### Manual install

```shell
git clone https://github.com/dockermgr/daapd "$HOME/.local/share/CasjaysDev/dockermgr/daapd"
bash -c "$HOME/.local/share/CasjaysDev/dockermgr/daapd/install.sh"
```
  
#### Just run

```shell
mkdir -p "$HOME/.local/share/srv/docker/daapd/"

git clone <https://github.com/dockermgr/daapd> "$HOME/.local/share/CasjaysDev/dockermgr/daapd"

cp -Rf "$HOME/.local/share/srv/docker/daapd/system/*" "$HOME/.local/share/srv/docker/daapd/"

sudo docker run -d \
--name="daapd" \
--hostname "checkip" \
--restart=unless-stopped \
--privileged \
-e TZ="${TZ:-${TIMEZONE:-America/New_York}}" \
-v "$HOME/.local/share/srv/docker/daapd/data":/data:z \
-v "$HOME/.local/share/srv/docker/daapd/config":/config:z \
-p PORT:INT_PORT \
TEMPLATE/TEMPLATE 1>/dev/null
```

## Author  

👤 **Jason Hempstead**  
