### Build
#### volumes
```
docker volume create transformers-cache
```
#### build
```
docker build -t gpt-dockerized .
```
#### run
```
docker run \
        --rm \
        -v transformers-cache:/root/.cache \
        -p 3000:3000 \
        gpt-dockerized:latest
```