#!/bin/bash -x

config_device()
{
	BASE_DIR=/home/ubuntu
	KUBE_PORTS="80,443,8008"
	KUBE_ADDR="0.0.0.0"
	PORT_EXPOSED=5005
	LOGFILE=${BASE_DIR}/serge-ai.log
}

init_actions()
{
  # Start Minikube
  minikube start --listen-address=${KUBE_ADDR} --ports=${KUBE_PORTS} 1>>$LOGFILE 2>&1
  # Create Kubernetes namespace
  kubectl create namespace serge-ai  1>>$LOGFILE 2>&1
  # Set Kubernetes context to the new namespace
  kubectl config set-context --current --namespace=serge-ai  1>>$LOGFILE 2>&1
  # Start Minikube tunnel in the background
  minikube tunnel 1>>$LOGFILE 2>&1 &
  kubectl apply -f $BASE_DIR/serge_ai_minikube.yaml  1>>$LOGFILE 2>&1
  # Forward port for the Serge deployment in the background
  kubectl relay --address ${KUBE_ADDR} --server.namespace=serge-ai svc/serge ${PORT_EXPOSED}:8008 1>>$LOGFILE 2>&1 &
}
config_device
init_actions