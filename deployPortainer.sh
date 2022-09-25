#!/bin/sh
#Checking whether username is passed to script
#A docker folder will be created inside this users home directory and container persistant data will be stored there
dockerUser=$1;
[ -z "$dockerUser" ] && echo "Please pass the username...!!!" && exit 0 || echo "Deploying Portainer for user $dockerUser";

#Checking & Removing existing container
echo "Checking if Portainer already deployed...";
container=$(docker ps -q --filter ancestor=portainer/portainer-ce );
echo $container;
[ -z "$container" ] && echo "No running container found" || docker rm -f $container;

#Deploying container
docker run -d -p 9000:9000 --network tunnel --name=portainer  --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /home/$dockerUser/docker/portainer/data:/data portainer/portainer-ce;
echo "Portainer deployment successfull...!!!";
exit 0