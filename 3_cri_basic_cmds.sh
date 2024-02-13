# 1.
crictl pull busybox
crictl pull nginx
# pulls an image from the reginstry

# 2.
crictl ps
# lists all the running containers

# 3.
crictl images
# lists all the images on the host

# 4.
crictl exec -it [container-id] ls 
crictl exec -it [container-id] /bin/bash
# executes a command inside a running container - here opens a bash shell inside cid

# 5. 
crictl logs [container-id]
# fetches container logs

# 6. 
crictl pods
# fetches pods ingo
