##### Microservices Demo by Google

I've tested this deployment files using microk8s in MacOS. The commands below contains the microk8s command, which you can omit if you've properly installed and configure your *kubectl* command.

###### Pre-requisite:
* microk8s installed and running
* microk8s add-ons installed and enabled
- dashboard
- dns
- helm
- helm3
- host-access
- host path-storage
- ingress
- metric-server
- storage 


* Your hosts file should contain similar entry below. This will vary what your microk8s IP receives from the bootp. To obtain the IP address, go to the multipass icon tool bar then click the open-shell. Once you are in the shell, run ```ip a``` or ```ifconfig``` command. 


```
192.168.64.3	kibana.my.laptop
192.168.64.3	elastic.my.laptop
192.168.64.3	enterprise-search.my.laptop
192.168.64.3	frontend.my.laptop
```

###### Instructions

1. Clone this repository
2. Run the commands below

```
microk8s kubectl create ns microservices-demo
microk8s kubectl apply -f *.yaml

```

3. Browse the URL frontend.my.laptop. This is defined in the the ingress. Run the following command to see:

```
microk8s kubectl -n microservices-demo get ingress 

NAME                CLASS   HOSTS                ADDRESS     PORTS   AGE
frontend-frontend   nginx   frontend.my.laptop   127.0.0.1   80      15d

```
