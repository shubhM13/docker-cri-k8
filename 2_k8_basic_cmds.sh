# 1. 
#get pods in a namespace
kubectl get pods
# list all pods in all namespaces
kubectl get pods --all-namespaces
# lists pods in a specific namespace
kubectl get pods -n <namespace>

# 2. 
kubectl apply -f deployment.yaml
kubectl apply -f config.yaml
# applies configuration in deployment.yaml to create or update resources

# 3.
kubectl delete
kubectl delete pods my-pod
# deletes resources by filenames, stdin, resources and names or by resources and label-selectors

# 4. 
kubectl logs  my-pod
# prints the logs from my-pod

#5.
kubectl exec -it my-pod -- /bin/bash
#exeutes an interactive shell in a specified pod 

#6.
kubectl get all
# list all resoources

#7. 
kubectl create deployment nginx --image=nginx
#create a resource

#8.
kubectl delete pod mypod
# delete resources

#9.
kubectl describe pods mypod
# show detailed information about a resource

#10.
kubectl logs mypod
#fetch logs from a container in the pods

#11.
kubectl scale deployment mydeployment --replicas=3
#scale a resource

#12.
kubectl autoscale deployment d1 --min=2 --max=5 --cpu-percent=80
#Automatically scale the set of pods that are managed by a deployment or replica set

#13
kubectl set image deployment/d1 nginx=nginx:1.9.1
kubectl set image deployment/<mydep> <container-name>=<new-image>
# Update the image of a deployment

#14
kubectl edit deployment deployment/d1
# Edit a resource 

#15
kubectl get events
# get events in a namespace

#16
kubectl top pod p1
# display resource (cpu/memory) usage

#17
kubectl annotate pods p1 --annotation=value
kubectl annotate pods <pod-name> <annotation-key>=<annotation-value>
# add or update annotations of one or more resources

#18
kubectl label pods p1 --new-label=value
kubectl label pods <pod-name> --<label-key>=<label-value>
# update labels of a reosource

#19
kubectl pod p1 -p '{"spec": {"containers": [{"name": "c1", "image": "i1"}]}}'
#update fields of a resource using strategic merge patch, a json merge patch, or a json patch

#20.
kubectl rollout restart deployment/d1
# restart a deployment

#21
kubectl rollout status deployment/d1
# view the rollout status of a deployment

#23
kubectl rollout undo deployment/d1
# Rollback to previous deployment

#24
kubectl config view
# view kubeconfig settings

#25
kubectl config use-context my-cluster-name
# switch between clusters

#26
kubectl port-forward pod/p1 8080:80
kubectl port-forward pod/<my-pod> <local-port>:<pod-port>
# forward more one or more port on the host to a pod

#27
kubectl get nodes
#get ndoes in a pod

#28
kubectl get deployments
#list all deployments in current context

#29
kubectl get services
# list all services in current context

#30
kubectl get secrets 
#list all secrets in the currebt context

#31
kubectl expose deployment <deployment> --type=LoadBalancer --port=80 --target=8080
#expose a deployment (application) to an external network (internet) as a service with port 80 of host to port 8080 on the target

#32
kubectl config set-context --current --user=<user-name>
# set the current contexts user as user-name

#33
kubectl create secret generic <secret-name> --from-literal=key=value
# create a generic secret 

#34
kubectl api-resources
#get the api resources

#35
kubectl create configmap app-config --from-file=app-config.properties
# need to store configuration data in ConfigMap to be used by pods.
# first create filenamed app-config.properties with your config data and then create a configMap


---------------
#1) kubectl get [cmd] (9)
kubectl get pods
kubectl get pods --all-namespaces
kubectl get pods -n <namespace>
kubectl get events
kubectl get all
kubectl get nodes
kubectl get deployments
kubectl get services
kubectl get secrets


#2) kubectl [cmd] pod [name] [cmd2 (optional)] (8)
kubectl delete pod mypod
kubectl delete service <service-name>
kubectl describe pod mypod
kubectl logs mypod-
kubectl top pod mypod
kubectl annotate pod mypod annotation=value
kubectl label pod mypod new-label=value
kubectl pod mypod -p '{"spec": {"containers": [{"name": "mycontainer","image": "newimage"}]}}'

#3) Deployment commands - kubectl [cmd] deployment [name] [argument (optional)] (7)
kubectl apply -f config.yaml
kubectl create deployment <dep-name> --image=<image>
kubectl edit deployment deployment/mydeployment
kubectl scale deployment mydep --replica=3
kubectl autoscale deployment mydeployment --min=2 --max=5 --cpu-percent=80
kubectl set image deployment/mydeployment nginx=nginx:1.9.1
kubectl expose deployment <dep-name> --type=LoadBalancer --port=80 --target-port=8080

#4) kubectl rollout [cmd] [deployment-name] (3)
kubectl rollout restart deployment/mydelpoyment
kubectl rollout status deployment/mydeployment
kubectl rollout undo deployment/mydeployment

#5) kubectl config [cmd] (5)
kubectl version
kubectl cluster-info
kubectl config view
kubectl config use-context my-cluster-name
kubectl config set-context --current --user=<user-name>
kubectl create configmap app-config --from-file=app-config.properties

#6) kubectl exec (2)
kubectl exec -it mypod -- /bin/bash
kubectl port-forward pod/p1 8080:80

#7) kubectl secrets
kubectl create secret generic <secret-name> --from-literal=key=value

#8) API resources
kubectl api-resources

--------------------

# Sample deployment.yaml -- LIVENESS & READINESS PROBE
apiVersion: apps/v1
kind: Deployment
metadata:
    name: myapp
spec:
    replicas:1
    selector:
        matchLabels:
            app: myapp
        template:
            metadata:
                labels:
                    app: myapp
            spec:
                containers:
                    name: myapp
                    image: myapp:1.0
                    livenessProbe:
                        httpGet:
                            path: /healthz
                            port: 8080
                        initialDelaySeconds: 3
                        periodSeconds: 3
                    readinessProbe:
                        httpGet:
                            path: /ready
                            port: 8080
                        initialDeplaySeconds: 3
                        periodSeconds: 3

kubectl apply -f deployment.yaml

# Sample deployment.yaml -- Using Persistent Volumes -- Application needs to store data persistently

-- 1. First create a PersistenVolume(PV) and PersistentVolumeClaim(PVC) in a pv-pvc.yaml file:

apiVersion: v1
kind: PersistentVolume
metadata:
    name: mypv
spec: 
    capacity:
        storage: 1Gi
    accessModes:
        - ReadWriteOnce
    persistentVolumeReclaimPolicy: Retain
    hostPath:
        path: /mnt/data
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: mypvc
spec:
    accessModes:
        - ReadWriteOnce
    resources:
        reuqests:
            storage: 1Gi

-------
kubectl apply -f pv-pvc.yaml
-------

-- 2. Modify the deployment to use the PVC - deplo
:.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: myapp
spec: 
    replicas: 1
    selector:
        matchLabels:
            app: myapp
    template:
        metadata:
            labels:
                app: myapp
        spec:
            containers:
            -   name: myapp
                image: myapp:1.0
                volumeMounts:
                -   mountPath: "/data"
                name: myvolume
            volumes:
            - name: myvolume
            persistentVolumeClaim:
                claimName: mypvc

--------
kubectl apply -f deploynt.yaml
--------








