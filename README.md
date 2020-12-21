# kubernetes-demo

## Prerequisite

###Install Docker
https://docs.docker.com/get-docker/

###Install Docker Compose
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
docker build -t valtech/kubernetes-demo-frontend .

docker run -p 8080:8080 --name kubernetes-demo-frontend valtech/kubernetes-demo-frontend
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
docker build . -t valtech/kubernetes-demo-backend

docker run -p 8080:8080 --name kubernetes-demo-backend valtech/kubernetes-demo-backend
Access: http://localhost:8080/api
```

## docker-compose

Run all in once by docker-compose (Requires building FE and BE docker images upfront)

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