#!/bin/bash

while ! docker exec -i some-drupal nc -z mysql 3306; do
	sleep 1
done

docker exec -i some-drupal ./vendor/drush/drush/drush site-install --db-url=mysql://root:mysecretpassword@mysql:3306/portal

docker exec -i some-drupal chmod -R 777 themes
docker exec -i some-drupal chmod -R 777 sites
docker exec -i some-drupal chmod -R 777 profiles
docker exec -i some-drupal chmod -R 777 modules
docker exec -i some-drupal chmod -R 777 core
docker exec -i some-drupal ./vendor/drush/drush/drush en -y apigee_edge swagger_ui_formatter apigee_edge_apiproduct_rbac features features_ui api_specification spec_publish
docker exec -i some-drupal ./vendor/drush/drush/drush key:save apigee_edge_connection_default --key-type=apigee_auth --key-provider=apigee_edge_environment_variables
docker exec -i some-drupal ./vendor/drush/drush/drush apigee-edge:sync
docker exec -i some-drupal ./vendor/drush/drush/drush cr
