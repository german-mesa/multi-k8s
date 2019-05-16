
docker build -t i028929/multi-client:latest -t i028929/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t i028929/multi-server:latest -t i028929/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t i028929/multi-worker:latest -t i028929/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push i028929/multi-client:latest
docker push i028929/multi-server:latest
docker push i028929/multi-worker:latest

docker push i028929/multi-client:$SHA 
docker push i028929/multi-server:$SHA 
docker push i028929/multi-worker:$SHA 

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=i028929/multi-client:$SHA
kubectl set image deployments/server-deployment server=i028929/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=i028929/multi-worker:$SHA