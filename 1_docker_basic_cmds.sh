# 1. 
docker run -d -p 80:80 nginx
# creates and starts a container in one operation
# an nginx container created and started on port 80 of the host and mapped to port 80 of the container -  in detached mode (in background)

# 2.
docker ps
# lists the running containers
docker ps -a
# lists all the containers on the host including the stopped ones

# 3.
docker build -t my-image:latest
# builds a docker image named 'my-image' with tag 'latest' from the dockerfile in the current directory

# 4.
docker images 
# list all the docker images available on the hosts (a container is the running instance of an image)

# 5.
docker pull ubuntu
docker pull nginx
# pulls the latest Ubuntu image/ repository from the docker Hub / registry 

# 6. 
docker rmi myimage
# remove one or more images

#7.
docker stop [container-id]
#stop a specified contianer

#8.
docker start [container-id]
#start a stopped container

#9. 
docker restart [container-id]
#restart a contianer

#10. 
docker rm [container-id]
#remove one or more container

#11.
docker exec -it [container-id] /bin/bash
#execute a command inside a container

#12.
docker logs [container-id]
# fetch logs from a container

#13. 
docker push my-image
#push an image to the registry or dockerhub

#14.
docker network create my-net
#create a network

#15.
docker volume create my-vol
#create a volume

#16.
docker login
#login to a docker registry

#17.
docker logout
# logout form the docker registry

#18.
docker tag myimage myrepo/myimage:tag
# tag an image into an repository

#19.
docker inspect [container-id]
#return low level info on a contianer

#20.
docker stats [container-id]
#display live stream of contianers resource usage stats

#21.
docker commit [contianer-id] mynewimage
#create a new image from a contianers changes

docker run -d -p 80:80 nginx
docker build -t img:tag
docker ps
docker ps -a
docker image
docker rm cid
docker rmi img
docker start cid
docker stop cid
docker restart cid
docker login 
docker logout
docker exec -it cid /bin/bash
docker volume create my-vol
docker network create my-net
docker logs cid
docker stats cid
docker inspect cid
docker tag myimage myrepo/myimage:tag
docker pull nginx
docker push myimg
docker commint cid mynewimage

docker run -d -p 80:80 nginx
docker image
docker ps
docker ps -a
docker rmi myimage
docker rm cid
docker start cid
docker stop cid
docker exec -it cid /bin/bash
docker login
docker logout

