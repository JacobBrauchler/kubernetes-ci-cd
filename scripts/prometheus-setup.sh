#!/bin/bash

# Start prometheus

kubectl create -f prometheus/deployment.yml

kubectl apply -f prometheus/service.yml

minikube service prometheus-service
