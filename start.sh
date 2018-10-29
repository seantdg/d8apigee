#!/bin/bash

docker build -t myapigee/d8 .
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
docker run --name some-drupal -p 8080:80 --link some-postgres:postgres -d \
	-e APIGEE_EDGE_ENDPOINT= \
	-e APIGEE_EDGE_ORGANIZATION=myorg \
	-e APIGEE_EDGE_USERNAME=someone@example.com \
	-e APIGEE_EDGE_PASSWORD=password \
	myapigee/d8
