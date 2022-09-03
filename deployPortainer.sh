#!/bin/sh
echo "Checking if Portainer already deployed...">deployPortainer.log;
container=$(docker ps -q --filter ancestor=portainer/portainer-ce )>>deployPortainer.log;
[ -z "$container" ] && echo "No running container found">>deployPortainer.log || docker rm -f $container;
echo "Deploying Portainer...">>deployPortainer.log;
sudo docker run -d -p 9000:9000 --name=portainer  --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /home/ubuntu/docker/portainer/data:/data portainer/portainer-ce;
echo "Portainer deployment successfull...">>deployPortainer.log;
exit 0
