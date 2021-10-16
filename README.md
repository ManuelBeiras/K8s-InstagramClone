# K8s-InstagramClone ✅ ![](https://progress-bar.dev/90/?title=Windows) ✅ ![](https://progress-bar.dev/90/?title=Linux) ✅ ![](https://progress-bar.dev/90/?title=macOS) 
Poryecto de FCT Dockerizado y montado en K8s, con todos los pasos necesarios para hacerla funcionar. Montada con entorno Windows Linux Subsystem (WSL) y Minikube. 

## Archivos necesarios para el funcionamiento de esta applicación

- postgres-config.yaml
- postgres-secret.yaml
- volume-claim.yaml
- volume.yaml
- postgres.yaml
- fctgram.yaml

## Comandos para K8s

Arrancamos Minikube y comprobamos el status de este:
```
minikube start --driver=docker (Windows y Linux)
minikube start --vm-driver=hyperkit (macOS)
minikube status
```
Conseguir información básica de los componentes de K8s:
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
Conseguir información extendida de los componentes de k8s:
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
Conseguir información detallada de un componente específico de k8s:
```
kubectl describe svc {svc-nombre}
kubectl describe node {node-nombre}
kubectl describe pod {pod-nombre}
kubectl describe configmap {configmap-nombre}
kubectl describe secret {secret-nombre}
kubectl describe all {all-nombre}
kubectl describe pv {pv-nombre}
kubectl describe pvc {pvc-nombre}
```
Conseguir logs de las aplicaciones:
```
kubectl logs {pod-nombre}
```
