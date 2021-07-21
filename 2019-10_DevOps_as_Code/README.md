# As Code Meetup Setup

## Infrastructure Secrets

1. Create a file `infrastructure/secrets.xlvals`
2. Put infrastructure secrets in file as follows:

```
kubeUrl=https://000.000.000.000:9999
kubeToken=kubetoket-01923134050145034505402409
```
## XL Release Secrets

1. Create a file `xl-release/secrets.xlvals`
2. Put **XL Release** secrets in file as follows:

```
xldeploy_XLDeployServer_Ecommerce_password=xxxxx
```

## Demo Flow:
1. Create the secrets.xlvals as above
2. Download and install Docker and xl-cli (https://docs.xebialabs.com/v.10.1/release/concept/get-started-with-devops-as-code#get-started)
3. Run `docker-compose up` to start environment
4. Run `xl apply --config config.yaml --file setup.yaml` - This configures the Release and Deploy Environments
5. Run `xl apply --config config.yaml --file xld-deploy-rest-o-rant.yaml` Deploy to Kubernetes
6. Run `xl apply --config config.yaml --file xlr-release-rest-o-rant.yaml` Deploy to Kubernetes using Release and Deploy

### Generating YAML with xl-cli
1. Make a new dir `mkdir cruft`
2. change to that dir `cd cruft`
3. Run `xl generate xl-deploy --config ../config.yaml -p "Applications/as-code-meetup" -f meetup.yaml`
