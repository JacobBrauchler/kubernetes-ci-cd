kubectl create -f signalfx/secret.yml
kubectl create -f signalfx/signalfx-integrations.yml    
kubectl create -f signalfx/signalfx-agent-configmap.yml 
kubectl create -f signalfx/signalfx-templates.yml       
kubectl create -f signalfx/signalfx-agent.yml