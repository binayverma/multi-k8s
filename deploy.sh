docker build -t binayverma/multi-client:latest -t binayverma/mutlti-client:$SHA -f ./client/Dockerfile ./client
docker build -t binayverma/multi-server:latest -t binayverma/mutlti-server:$SHA -f ./client/Dockerfile ./server
docker build -t binayverma/multi-worker:latest -t binayverma/mutlti-worker:$SHA -f ./client/Dockerfile ./worker

docker push binayverma/multi-client:latest
docker push binayverma/multi-server:latest
docker push binayverma/multi-worker:latest

docker push binayverma/multi-client:$SHA
docker push binayverma/multi-server:$SHA
docker push binayverma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=binayverma/multi-client:$SHA
kubectl set image deployments/server-deployment server=binayverma/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=binayverma/multi-worker:$SHA
