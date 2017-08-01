# Create netsil namespace
kubectl create -f netsil/netsil-ns.yml

# Create netsil replication controller
kubectl create -f netsil/netsil-rc.yml

# Create netsil service
kubectl create -f netsil/netsil-svc.yml

# Create Netsil collector
kubectl create -f netsil/collector.yml

