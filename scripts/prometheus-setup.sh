#!/bin/bash

# Start prometheus

# kubectl create -f prometheus/monitoring-namespace.yml

kubectl create -f prometheus/prometheus-config.yml

kubectl create -f prometheus/deployment.yml

kubectl apply -f prometheus/service.yml

# kubectl create -f prometheus/node-exporter-daemonset.yml

# minikube service --namespace=monitoring prometheus-service

kubectl apply -f prometheus/exporters.yml

# minikube service prometheus-service

# helm init

# helm install --namespace monitoring --name ksm stable/kube-state-metrics
