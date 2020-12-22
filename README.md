# kubernetes-demo

## Prerequisite

### Install Docker
https://docs.docker.com/get-docker/

### Install Docker Compose
https://docs.docker.com/compose/install/

### Install Node, yarn


## kubernetes-demo-frontend

Build application:
```
cd kubernetes-demo-frontend
yarn install
yarn build
```

Build docker image and run it:
```
docker build -t valtechchregistry.azurecr.io/kubernetes-demo-frontend .

docker run -p 8080:8080 --name kubernetes-demo-frontend valtechchregistry.azurecr.io/kubernetes-demo-frontend
```

## kubernetes-demo-backend

Build spring-boot application:

```
cd kubernetes-demo-backend
./gradlew build
./gradlew bootRun
```

Build docker image and run it:
```
docker build . -t valtechchregistry.azurecr.io/kubernetes-demo-backend

docker run -p 8080:8080 --name kubernetes-demo-backend valtechchregistry.azurecr.io/kubernetes-demo-backend
Access: http://localhost:8080/api
```

## kubernetes-demo-proxy

Build proxy docker image
```
cd kubernetes-demo-proxy
docker build . -t valtechchregistry.azurecr.io/kubernetes-demo-proxy

docker run -p 8080:8080 --name kubernetes-demo-proxy valtechchregistry.azurecr.io/kubernetes-demo-proxy
Access: http://localhost:8080
```

## docker-compose

Run all in once by docker-compose (Requires building FE/BE and proxy docker images upfront)

```
docker-compose up -d
http://localhost:8080/api
```

Run in debug

Enable:

```
#    environment:
#      - SPRING_DEBUG=true
```
and run again
```
docker-compose up -d
http://localhost:8080/api
```