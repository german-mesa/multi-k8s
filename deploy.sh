
docker build -t german-mesa/multi-client:latest -t german-mesa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t german-mesa/multi-server:latest -t german-mesa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t german-mesa/multi-worker:latest -t german-mesa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push german-mesa/multi-client:latest
docker push german-mesa/multi-server:latest
docker push german-mesa/multi-worker:latest

docker push german-mesa/multi-client:$SHA 
docker push german-mesa/multi-server:$SHA 
docker push german-mesa/multi-worker:$SHA 

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=german-mesa/multi-client:$SHA
kubectl set image deployments/server-deployment server=german-mesa/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=german-mesa/multi-worker:$SHA