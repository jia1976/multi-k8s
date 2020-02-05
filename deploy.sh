docker build -t jia1976/multi-client:latest -t jia1976/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jia1976/multi-server:latest -t jia1976/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jia1976/multi-worker:latest -t jia1976/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jia1976/multi-client:latest
docker push jia1976/multi-server:latest
docker push jia1976/multi-worker:latest

docker push jia1976/multi-client:$SHA
docker push jia1976/multi-server:$SHA
docker push jia1976/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=jia1976/multi-server:$SHA
kubectl set image deployment/client-deployment client=jia1976/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=jia1976/multi-worker:$SHA