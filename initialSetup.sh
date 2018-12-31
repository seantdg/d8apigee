#!/bin/bash

while ! docker exec -i some-drupal nc -z mysql 3306; do
	sleep 1
done

docker exec -i some-drupal ./vendor/drush/drush/drush site-install --db-url=mysql://root:mysecretpassword@mysql:3306/portal

docker exec -i some-drupal chmod -R 777 themes
docker exec -i some-drupal chmod -R 777 sites
docker exec -i some-drupal ./vendor/drush/drush/drush cr
docker exec -i some-drupal ./vendor/drush/drush/drush en -y apigee_edge swagger_ui_formatter apigee_edge_apiproduct_rbac
docker exec -i some-drupal ./vendor/drush/drush/drush key:save apigee_edge_connection --key-type=apigee_auth --key-provider=apigee_edge_environment_variables
docker exec -i some-drupal ./vendor/drush/drush/drush apigee-edge:sync


