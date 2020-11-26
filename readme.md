#### create volume for models cache
```
docker volume create transformers-cache
```
#### build
```
docker build -t ru-gpt-3 .
```
#### run locally
```
docker run \
        --rm \
        -v transformers-cache:/root/.cache \
        -p 3000:3000 \
        ru-gpt-3:latest
```

#### run on ecs
```
aws ecs run-task \
	--task-definition ru-gpt:1 \
	--cluster main \
	--count 1 \
	--region us-east-1 \
	--launch-type FARGATE \
	--platform-version 1.4.0 \
	--network-configuration "{\"awsvpcConfiguration\":{\"subnets\":[\"subnet-f3dfeadd\"],\"assignPublicIp\":\"ENABLED\"}}" \
	--overrides "{\"containerOverrides\":[{\"name\":\"ru-gpt\",\"command\":[\"python\", \"generate_transformers.py\", \"--model_type=gpt2\", \"--model_name_or_path=sberbank-ai/rugpt3large_based_on_gpt2\", \"--k=5\", \"--p=0.95\", \"--length=100\", \"--no_cuda\", \"--prompt='Сейчас я поеду кататься на велосипеде и набираться здоровья' \"]}]}"
```

#### get output
```
aws logs get-log-events \
	--region us-east-1 \
	--log-group-name /ecs/ru-gpt \
	--log-stream-name ecs/ru-gpt/{task id}
```