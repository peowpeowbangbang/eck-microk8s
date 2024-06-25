

#### Note for Kibana
- Kibana might fail if the elastic username and password is wrong. use the get_username.sh to get the password from the secret.
#### Note for Elasticsearch
- Anonymous is enabled in Elasticsearch with a role as admin. You'll find this in the 1-es-deploy.yaml (NOT RECOMMENDED)
- ```elastic.yaml, kibana.yaml, enterpriseserach.yaml``` are now part of CustomResourceDefinition (CRD) in Kubernetes. You don't need to look anywhere anymore :)
#### Notes for the FQDN
- In case you wonder how the frontend is served, it is done via the NGINX proxy now.
- It is configued to allow more than 100MB of data by using annotations that is defined by the NGINX manual.
#### Note for the certificates
- You will have to generate a self-signed certificate, make sure you don't lose this. 


#### Pre-requisite

I installed microk8s in a MacBook Pro M3 Pro with 36GB, running Sonoma 14.5

1. microk8s installed in MacOS with the following spec:
```
CPU(s):      6
Disk:     50GB
Memory:   24GB
```
2. Enable the following addons in microk8s:

```
addons:
  enabled:
    dashboard            # (core) The Kubernetes dashboard
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    storage              # (core) Alias to hostpath-storage add-on, deprecated
```

3. Edit your hosts file. You will need to obtain the IP address of the microk8s instance by going to the microk8s console and running ```ip a``` or ```ifconfig``` config

```
192.168.64.3	kibana.my.laptop
192.168.64.3	elastic.my.laptop
192.168.64.3	enterprise-search.my.laptop
192.168.64.3	frontend.my.laptop
```

4. Obtain an enterprise license. For elasticians, this is available internally.
5. Follow the Official instructions how to install the ECK operator in this url
   
   https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html
6. clone this repo using git then ```cd eck-microk8s```
7. create an elastic-system namespace ```microk8s kubectl create ns elastic-system```
8. apply the numbered yaml one by one in order. Excep for the shell file that you will have to run in the bash prompt
    ```microk8s kubectl -n elastic-system apply -f 1-es-deploy.yaml```
