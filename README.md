# K8s-InstagramClone ✅ ![](https://progress-bar.dev/90/?title=Windows) ✅ ![](https://progress-bar.dev/90/?title=Linux) ✅ ![](https://progress-bar.dev/90/?title=macOS) 
Proyecto de FCT Dockerizado y montado en K8s, con todos los pasos necesarios para hacerla funcionar + cheat sheet. Montada con entorno Windows Linux Subsystem (WSL) y Minikube. 

## Archivos necesarios para el funcionamiento de esta applicación

- postgres-config.yaml
- postgres-secret.yaml
- volume-claim.yaml
- volume.yaml
- postgres.yaml
- fctgram.yaml
- database.sql

## Ejecución del proyecto
1. Estando desde la raíz de todos los archivos aplicamos todos los .yaml:
```
kubectl apply -f volume.yaml
kubectl apply -f volume-claim.yaml
kubectl apply -f postgres-config.yaml
kubectl apply -f postgres-secret.yaml
kubectl apply -f postgres.yaml
kubectl apply -f fctgram.yaml
```
2. Copiamos la base de datos al contenedor de postgres y la ejecutamos:
```
kubectl get all --> Buscar y copiar postgres-deployment-{}
kubectl cp ./database.sql postgres-deployment-{}:database.sql --> Copias la base de datos en el contenedor.
kubectl exec -it postgres-deployment-{} -- /bin/bash --> Entramos en el contenedor de forma interactiva y lanzamos:
su postgres
psql postgres < database.sql
```
3. Actualizamos la base de datos de la aplicación y creamos un superusuario: (⚠ Crítico para que la app funcione ⚠)
```
kubectl exec -it webapp-deployment-67c94d7c7f-zjpks -- python manage.py migrate --> Actualiza la base de datos.
kubectl exec -it webapp-deployment-67c94d7c7f-zjpks -- /bin/bash --> Entramos en el contenedor de forma interactiva y lanzamos:
python manage.py createsuperuser --> (Te pedirá Nombre, correo, contraseña)
```
4. Accedemos a la aplicación:

⚠ Para macOS ⚠
```
minikube ip --> Conseguimos la ip de Minikube, con esto accedemos a la aplicación a través de {minikubeip:30100}
```
⚠ Para Windows y Linux ⚠

Se ha detectado a fecha 16/10/2021 que si usas el driver de docker desktop (--driver=docker) tanto en Windows como en Linux no puedes acceder con la ip de Minikube. 

✅ Solución ✅
```
minikube service webapp-service --> Tras hacer esto te dirá cuál es la ip para acceder a la aplicación.
```
Una vez dentro de la aplicación, para acceder al apartado administrativo de la aplicación:
```
{ip:puerto/FCT} --> Podrás acceder con el usuario administrador creado antes.
```
## Eliminamos todo
```
kubectl delete deploy webapp-deployment -n default
kubectl delete deploy postgres-deployment -n default
kubectl delete service webapp-service
kubectl delete service postgres-service
kubectl delete configmap postgres-config
kubectl delete secret postgres-secret
```
⚠ Volúmenes ⚠

Existe un problema con los volúmenes que al borrarlos se queda en estado "Terminating" y no se borran.

✅ Solución ✅
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
        uid: "{*}"
Confirmamos la edición con:
:wq!
Ahora nos deja eliminar tanto el volumen como el volumen claim:
kubectl delete pv postgres-pv
kubectl delete pvc postgres-pvc
```

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
Conseguir información detellada de los recursos de K8s (Lanzar comando desde la consola):
```
kubectl api-resources
```

## Links
- postgresql image en Docker Hub: https://hub.docker.com/_/postgres
- fctgram image en Docker Hub: https://hub.docker.com/r/manuelbeiras/fctgram
- Documentación oficial de K8s: https://kubernetes.io/docs/home/
- Documentación oficial de Minikube: https://minikube.sigs.k8s.io/docs/
- Instalar Minikube en WSL: https://lemoncode.net/lemoncode-blog/2021/6/12/usando-kubernetes-en-local-minikube-instalacion-en-windows

## ⚠ Apuntes finales ⚠
Este proyecto de K8s está hecho por mí desde de 0 teniendo poca experiencia en este mundillo.
Todo tipo de ayuda/feedback de como mejorar es más que bienvenida.
Puedes contactar conmigo a través de:
https://www.linkedin.com/in/manuel-beiras-belloso-826063218/
