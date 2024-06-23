#!/bin/bash

microk8s kubectl create secret generic eck-license --from-file=license-release-orchestration-enterprise.json -n elastic-system
microk8s kubectl label secret eck-license "license.k8s.elastic.co/scope"=operator -n elastic-system
microk8s kubectl -n elastic-system get configmap elastic-licensing -o json | jq .data
