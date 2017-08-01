#!/bin/bash

# Get rid of previous minikube intances
minikube delete; sudo rm -rf ~/.minikube; sudo rm -rf ~/.kube

# Start kubernetes cluster
minikube start --memory 8000 --cpus 2 --kubernetes-version v1.6.0

# Enable heapster and ingress
minikube addons enable heapster; minikube addons enable ingress; 

# Start the kubernetes dashboard
sleep 30; minikube service kubernetes-dashboard --namespace kube-system

# Set up the cluster registry
kubectl apply -f manifests/registry.yml

# Wait for registry to finish deploying
kubectl rollout status deployments/registry

# Start the etcd operator and service
scripts/etcd.sh

# Creat the etcd client
kubectl create -f manifests/etcd-job.yml

# Checks the statys of the etcd client
kubectl describe jobs/etcd-job

# Create rest of the services
kubectl apply -f manifests/all-services.yml

# Inital build of the monitor-scale service
docker build -t 127.0.0.1:30400/monitor-scale:`git rev-parse --short HEAD` -f applications/monitor-scale/Dockerfile applications/monitor-scale

# Set up proxy to push monitor scale image
docker stop socat-registry; docker rm socat-registry; docker run -d -e "REGIP=`minikube ip`" --name socat-registry -p 30400:5000 chadmoon/socat:latest bash -c "socat TCP4-LISTEN:5000,fork,reuseaddr TCP4:`minikube ip`:30400"

# Push monitor scale
docker push 127.0.0.1:30400/monitor-scale:`git rev-parse --short HEAD`

# Stop the proxy
docker stop socat-registry

# Open registry UI
minikube service registry-ui

# Create the monitor-scale deployment and service
sed 's#127.0.0.1:30400/monitor-scale:latest#127.0.0.1:30400/monitor-scale:'`git rev-parse --short HEAD`'#' applications/monitor-scale/k8s/deployment.yaml | kubectl apply -f -

# Wait for the monitor-scale deployment to finish
kubectl rollout status deployment/monitor-scale

# bootstrap the puzzle and mongo
scripts/puzzle.sh

# Wait for deployment and service
kubectl rollout status deployment/puzzle

# Bootstrap kr8sswordz
scripts/kr8sswordz-pages.sh

# Wait for deployment and service
kubectl rollout status deployment/kr8sswordz

# Start the web app
minikube service kr8sswordz

# # Start Prometheus

# scripts/prometheus-setup.sh

# # Start DataDog

# kubectl create -f dd-agent.yaml