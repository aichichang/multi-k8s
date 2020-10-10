docker build -t aichichangnandos/multi-client:latest -t aichichangnandos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aichichangnandos/multi-server:latest -t aichichangnandos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aichichangnandos/multi-worker:latest -t aichichangnandos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aichichangnandos/multi-client:latest
docker push aichichangnandos/multi-server:latest
docker push aichichangnandos/multi-worker:latest

docker push aichichangnandos/multi-client:$SHA
docker push aichichangnandos/multi-server:$SHA
docker push aichichangnandos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aichichangnandos/multi-server:$SHA
kubectl set image deployments/client-deployment client=aichichangnandos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aichichangnandos/multi-worker:$SHA