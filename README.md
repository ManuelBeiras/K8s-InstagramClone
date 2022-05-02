# K8s-InstagramClone ✅ ![](https://progress-bar.dev/100/?title=Windows) ✅ ![](https://progress-bar.dev/100/?title=Linux) ✅ ![](https://progress-bar.dev/100/?title=macOS) 
Dockerized Final degree project mounted on K8s, with all the necessary steps to make it work + cheat sheet. Assembled with Windows Linux Subsystem (WSL) and Minikube environment.

## Files necessary for the operation of this application.

- postgres-config.yaml
- postgres-secret.yaml
- volume-claim.yaml
- volume.yaml
- postgres.yaml
- fctgram.yaml
- database.sql

## Project execution
1. Being from the root of all the files we apply all the .yaml:
```
kubectl apply -f volume.yaml
kubectl apply -f volume-claim.yaml
kubectl apply -f postgres-config.yaml
kubectl apply -f postgres-secret.yaml
kubectl apply -f postgres.yaml
kubectl apply -f fctgram.yaml
```
2. We copy the database to the postgres container and execute it:
```
kubectl get all --> Find and copy postgres-deployment-{}
kubectl cp ./database.sql postgres-deployment-{}:database.sql --> You copy the database into the container.
kubectl exec -it postgres-deployment-{} -- /bin/bash --> We enter the container interactively and launch:
su postgres
psql postgres < database.sql
```
3. We update the application database and create a superuser: (⚠ Critical for the app to work ⚠)
```
kubectl get all --> Find and copy webapp-deployment-{}
kubectl exec -it webapp-deployment-{} -- python manage.py migrate --> Update the database.
kubectl exec -it webapp-deployment-{} -- /bin/bash --> We enter the container interactively and launch:
python manage.py createsuperuser --> (It will ask you for name, email, password)
```
4. We access the application:

⚠ For macOS ⚠
```
minikube ip --> We get the Minikube IP, with this we access the application through {minikubeip:30100}
```
⚠ For Windows and Linux ⚠

It has been detected as of 10/16/2021 that if you use the docker desktop driver (--driver=docker) on both Windows and Linux you cannot access with the Minikube IP.

✅ Solution ✅
```
minikube service webapp-service --> After doing this, it will tell you what the IP is to access the application.
```
Once inside the application, to access the administrative section of the application:
```
{ip:port/FCT} --> You can access with the administrator user created before.
```
## We remove everything
```
kubectl delete deploy webapp-deployment -n default
kubectl delete deploy postgres-deployment -n default
kubectl delete service webapp-service
kubectl delete service postgres-service
kubectl delete configmap postgres-config
kubectl delete secret postgres-secret
```
⚠ Volumes ⚠

There is a problem with the volumes that when they are deleted they remain in the "Terminating" state and they are not deleted.

✅ Solution ✅
```
kubectl get pv
kubectl edit pv postgres-pv
Eliminamos:
"claimRef:
        apiVersion: v1
        kind: PersistentVolumeClaim
        name: my-app-pvc-my-app-0
        namespace: default
        resourceVersion: "{*}"
        uid: "{*}""
We confirm the edition with:
:wq!
Now it lets us delete both the volume and the claim volume:
kubectl delete pv postgres-pv
kubectl delete pvc postgres-pvc
```

## Commands for K8s

We start Minikube and check its status:
```
minikube start --driver=docker (Windows y Linux)
minikube start --vm-driver=hyperkit (macOS)
minikube status
```
Get basic information of K8s components:
```
kubectl get node
kubectl get pod
kubectl get svc
kubectl get configmap
kubectl get secret
kubectl get all
kubectl get pv
kubectl get pvc
```
Get extended information on k8s components:
```
kubectl get node -o wide
kubectl get pod -o wide
kubectl get svc -o wide
kubectl get configmap -o wide
kubectl get secret -o wide
kubectl get all -o wide
kubectl get pv -o wide
kubectl get pvc -o wide
```
Get detailed information on a specific k8s component:
```
kubectl describe svc {svc-name}
kubectl describe node {node-name}
kubectl describe pod {pod-name}
kubectl describe configmap {configmap-name}
kubectl describe secret {secret-name}
kubectl describe all {all-name}
kubectl describe pv {pv-name}
kubectl describe pvc {pvc-name}
```
Get application logs:
```
kubectl logs {pod-name}
```
Get detailed information of K8s resources (Launch command from console):
```
kubectl api-resources
```

## Links
- postgresql image on Docker Hub: https://hub.docker.com/_/postgres
- fctgram image on Docker Hub: https://hub.docker.com/r/manuelbeiras/fctgram
- Official K8s Documentation: https://kubernetes.io/docs/home/
- Official Minikube Documentation: https://minikube.sigs.k8s.io/docs/
- Install Minikube on WSL: https://lemoncode.net/lemoncode-blog/2021/6/12/usando-kubernetes-en-local-minikube-instalacion-en-windows

## ⚠ Final notes ⚠
This K8s project is made by me from 0 having little experience in thisfield.

Any kind of help/feedback on how to improve is more than welcome.

You can contact me through:
https://www.linkedin.com/in/manuel-beiras-belloso/
