# d8apigee

## Pre-reqs

Add your org details to the APIGEE_ variables in start.sh

## Instance Start

```
./start.sh
```

## Drupal Install

Navigate to $IP:8080

Use the following details:
- English
(Next)
- Standard
(Next)
- PostgreSQL
- name: postgres
- username: postgres
- password: mysecretpassword
- Advanced -> Host: postgres
(Next)
- wait...
(Next)
- Site name: d8
- Site email: d8@example.com
- username: admin
- pass: password
- untick "Check for updates automatically"
(Next)

## Install Apigee Module

- Manage -> Extend
- Search "apigee"
- Tick "Apigee Edge", "Apigee Edge: API Product RBAC"
- Click Install
(observe "You must enable... modules...)
- Continue

## Configure Connection

- Manage -> Configuration -> Apigee Edge -> General
- Authentication Key
- Type: Basic authentication
- Click "create new basic auth key"
- Key name: mykey
- key type: Apigee Edge Basic Authentication
- Provider: Apigee Edge Basic Authentication: Environment Variables
- Save
- Select radio button for "mykey" 
- Send Request (validate settings are correct)
- Save

## Sync Developers
- Manage -> Configuration -> Apigee Edge -> Developers
- Synchronization
- Now (first time)
- Background

## Add SmartDocs
- Manage -> Extend
- Search "swagger"
- Tick "Swagger UI ..."
- Click Install

-  Structure > Content types 
- Create new Content Type 
- Name: API Specification
- Save and Manage Fields
- Add Field
- File
- Label: Specification
- Next
- Save field settings
- Allow file extensions: yaml,yml,json
- Save settings
- Click "Manage Display" on the tab menu
- Change the "Format" to "Swagger UI" for "Specification" field
- Save

- Manage -> Content
- Add Content
- API Specification
- Title: Petstore
- Specification: swagger.yml (this can be anything inc. OAS 3.0)
- Save

Note: If the content does not render correctly, try clearing the cache by navigating to Configuration > Development > Performance and clicking Clear all caches.


## Other activites
Now all the defaults are in place for Developer or App Registration etc. Docs for configuring the defaults are here: https://www.drupal.org/docs/8/modules/apigee-edge

## References

https://www.drupal.org/project/apigee_edge
https://hub.docker.com/_/drupal/
https://hub.docker.com/_/postgres/
https://www.drupal.org/docs/8/modules/apigee-edge
