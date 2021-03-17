docker build -t sgriggs/multi-client:latest -t sgriggs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sgriggs/multi-server:latest -t sgriggs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sgriggs/multi-worker:latest -t sgriggs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sgriggs/multi-client:latest
docker push sgriggs/multi-server:latest
docker push sgriggs/multi-worker:latest

docker push sgriggs/multi-client:$SHA
docker push sgriggs/multi-server:$SHA
docker push sgriggs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sgriggs/multi-client:$SHA
kubectl set image deployments/server-deployment server=sgriggs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sgriggs/multi-worker:$SHA