#!/bin/bash

openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -sha256 -subj "/CN=elastic.my.laptop" -days 1024 -out ca-elastic.crt -extensions san -config <(echo '[req]';
echo 'distinguished_name=req';
echo '[san]';
echo 'subjectAltName=DNS:elastic.my.laptop')

openssl req -x509 -new -nodes -key ca.key -sha256 -subj "/CN=kibana.my.laptop" -days 1024 -out ca-kibana.crt -extensions san -config <(echo '[req]';
echo 'distinguished_name=req';
echo '[san]';
echo 'subjectAltName=DNS:kibana.my.laptop')

microk8s kubectl create secret tls kibana-my-laptop-tls --cert=ca-kibana.crt --key=ca.key -n elastic-system
microk8s kubectl create secret tls elastic-my-laptop-tls --cert=ca-elastic.crt --key=ca.key -n elastic-system
