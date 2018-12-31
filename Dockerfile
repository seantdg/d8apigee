FROM drupal:8-apache

RUN apt-get update && apt-get install -y git vim unzip curl mysql-client netcat
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN rm composer-setup.php

COPY composer.json composer.json

RUN ./composer.phar update
RUN ./composer.phar require cweagans/composer-patches
RUN ./composer.phar require drupal/apigee_edge
RUN ./composer.phar require drupal/swagger_ui_formatter
RUN ./composer.phar require drush/drush
RUN ./composer.phar require drupal/features

RUN mkdir libraries && curl -sSL https://github.com/swagger-api/swagger-ui/archive/v3.19.4.tar.gz -o swagger.tar.gz && tar -xvzf swagger.tar.gz && rm swagger.tar.gz  && mv swagger-ui-3.19.4 libraries/swagger_ui

RUN yes | ./vendor/drush/drush/drush init
ADD ./api_specification ./modules/custom/features/api_specification
ADD ./spec_publish ./modules/spec_publish
ADD ./swagger.json ./private/assets/swagger.json
