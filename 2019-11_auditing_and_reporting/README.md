# Auditing and Reporting Demo

## Setup

1. Setup **Slack** chat room and create a authentication token or use `#ohiodevroom` with an existing url.
1. create `secrets.xlvals` file as follows:

  ```
  artifactory_Server_Ecommerce_password=admin
  blackduck_Server_Ecommerce_password=<YOUR BLACKDUCK PASSWORD>
  fortify_Server_Ecommerce_password=<YOUR FORTIFY PASSWORD>
  git_Repository_Ecommerce_password=<YOUR GIT PASSWORD>
  jira_Server_Ecommerce_password=<YOUR JIRA PASSWORD>
  sonar_Server_Ecommerce_password=<YOUR SONAR PASSWORD>
  xldeploy_XLDeployServer_Ecommerce_password=<YOUR XLD PASSWORD>
  snow_url=<YOUR DEV URL>
  snow_username=admin
  snow_password=<YOUR DEV PASSWORD>
  jira_user=<YOUR JIRA USER NAME>
  jira_password=<YOUR JIRA TOKEN>
  slack_url=https://hooks.slack.com/services/zjASWEASm2lO4jSJmfwQuvSa/T02GN6UQX/BLC332WKF
  slack_user=rbroker
  slack_channel=#ohiodevroom
  ```
1. apply `xebialabs.yaml` file

  ```
  xl apply -f xebialabs.yaml
  ```
