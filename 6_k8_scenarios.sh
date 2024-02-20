: '
1. Rolling Update of an Application
Scenario: Update an application to a new version using a rolling update strategy to ensure zero downtime.
Explanation: This scenario demonstrates how to update an application deployed on Kubernetes without downtime by gradually replacing old pods with new ones.
 '
#check current version
kubectl describe deployment myapp
#update the image
kubectl set image deployment/myapp myapp=myapp:v2
#watch the rollout status
kubectl rollout status deployment/myapp
#verify the update
kubectl get pods -l app=myapp


: '
2. Backup and Restore ConfigMap
Scenario: Backup a ConfigMap and restore it in case of accidental deletion.
Explanation: ConfigMaps hold configuration data that can be used by pods. Backing up and restoring ConfigMaps can be crucial for maintaining application configurations.
'
#backup the ConfigMap:
kubectl get configMap myconfig -o yaml > myconfig_backup.yaml
#delete the ConfigMap (simulating accidental deletion)
kubectl delete configmap myconfig
#restore the configMap
kubectl apply -f myconfig_backup.yaml

 
: '
3. Namespace Cleanup
Scenario: Clean up all resources in a namespace without deleting the namespace itself.
Explanation: This is useful for resetting a namespace to a clean state without affecting other namespaces.
'
# delete all deployments
kubectl delete deployments --all -n namespace
# delete all services
kubectl delete sercices --all -n namespace
# delete all pods
kubectl delete pods --all -n namespace


: '
4. Debugging a Pod
Scenario: Debug why a pod is not running as expected by inspecting its logs and executing commands inside the container.
Explanation: This scenario helps in troubleshooting application issues within a Kubernetes pod.
'
#get pod details
kubeclt describe pod p1
#view pod logs
kubectl logs p1
#execute a bash command inside the pod
kubectl exec -it p1 -- /bin/bash


: '
5. Scaling StatefulSet
Scenario: Scale a StatefulSet up and down based on demand.
Explanation: StatefulSets are used for applications that require stable, unique network identifiers, stable persistent storage, and ordered deployment and scaling.
'
#scale up the StatefulSet
kubectl scale statefulset ss1 --replicas=5
#verify the scaling action
kubectl get pods -l app=ss1
#scale down the StatefulSet
kubectl scale statefulset ss1 --replicas=3


: '
6. Updating Resource Limits
Scenario: Update the CPU and memory limits for a deployment.
Explanation: Adjusting resource limits allows for better resource management and ensures that applications have the necessary resources to function optimally.
'
#edit the deployment
kubectl edit deployment myapp # (In the editor, update the resource section under the container specification)
#verify the deployment update
kubectl describe deployment myapp
#check the new pod resource allocations
kubectl get pods -l app=myapp -o yaml

: '
7. Creating and Using a Secret
Scenario: Create a secret for storing sensitive information and use it in a pod.
Explanation: Secrets are used to store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys.
'
#create a secret
kubectl create secret generic mysecret --from-literal=password=mysecretpassword
#create a pod that uses the secret
#(First, prepare a pod definition that mounts the secret)
#apply the pod definition
kubectl apply -f mypod_using_secret.yaml


: '
8. Monitoring Pod Resource Usage
Scenario: Monitor the CPU and memory usage of pods to ensure they are not exceeding their allocated resources.
Explanation: Monitoring resource usage helps in identifying pods that are over-utilizing resources, potentially affecting other applications.
'
#view resource usage for all pods
kubectl top pod
#get detailed metric for a specific pod
kubectl top pod p1
# describe the pod to see resource limits
kubectl describe pod p1


: '
9. Rolling Restart of Deployments
Scenario: Perform a rolling restart of all pods in a deployment to refresh the application without downtime.
Explanation: A rolling restart is useful for applying configuration changes, secret updates, or simply refreshing the application instances.
'
#initiate a rolling restart
kubectl rollout restart deployment app1
#watch the rollout status
kubectl rollout status deployment app1
#verify that pods have been replaced
kubectl get pods -l app=app1

: '
10. Migrating Services Between Namespaces
Scenario: Migrate a service and its deployment from one namespace to another.
Explanation: This scenario is useful when reorganizing applications across different namespaces for better management and isolation.
'
#export the service and deployment to yaml file
kubectl get deployment myapp -n oldnamespace -o yaml > myapp-deployment.yaml
kubectl get service myapp -n oldnamespace -o yaml > myapp-service.yaml
#edit the yaml files to update the namespace to the new one
#apply the yaml files in the new namespace
kubectl apply -f myapp-deployment.yaml
kubectl apply -f myapp-service.yaml
#delete the old namespace
kubectl delete deployment myapp -n oldnamespace
kubectl delete deployment myapp -n oldnamespace


: '
11. Securing Pod Communication with Network Policies
Scenario: Restrict traffic to a pod only from specific pods within the same namespace.
Explanation: Network policies are essential for securing pod-to-pod communication in a Kubernetes cluster.
'
#create a network policy yaml file (network-policy.yaml)
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
    name: allow-specific-pod
    namespace: mynamespace
spec:
    podSelector:
        matchLabels:
            app: myapp
    ingress:
        from:
            podSelector:
                matchLabels:
                    app: allowed-app

#apply network policy
kubectl apply -f network-policy.yaml

#verify that the network policy is applied
kubectl get networkpolicy -n namespace


: '
2. Automatically Scaling Pods Based on CPU Usage
Scenario: Configure Horizontal Pod Autoscaler (HPA) to automatically scale a deployment based on CPU usage.
Explanation: HPA adjusts the number of pods in a deployment, replica set, or stateful set based on observed CPU utilization.
'
# deploy an application (if not already deployed)
kubectl create deployment autoscale-app --image=nginx
#expose deployment as a service
kubectl expose deployment autoscalse-app --port=80 --type=ClusterIP
#create Horizontal PoD Autoscale (HPA)
kubectl autoscale deployment autoscale-app --cpu-percent=50 --min=1 --max=10
#monitor HPA
kubectl get hpa autoscale-app --watch

kubectl create deployment autoscale-app --image=nginx
kubectl expose deployment autoscale-app --port=80 --type=ClusterIP
