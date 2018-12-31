#!/bin/bash

docker build -t myapigee/d8 .
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql:8.0.3
docker run --name some-drupal -p 8080:80 --link some-mysql:mysql -d \
	-e APIGEE_EDGE_AUTH_TYPE=basic \
	-e APIGEE_EDGE_ENDPOINT=https://api.enterprise.apigee.com/v1 \
	-e APIGEE_EDGE_ORGANIZATION=myorg \
	-e APIGEE_EDGE_USERNAME=someone@example.com \
	-e APIGEE_EDGE_PASSWORD=password \
	myapigee/d8
