# helm-kubectl-aws
helm + kubectl + awscli docker helper

```bash
$ docker run -it \
    -e AWS_ACCESS_KEY_ID="[YOUR_AWS_ACCESS_KEY_ID]" \
    -e AWS_SECRET_ACCESS_KEY="[YOUR_AWS_SECRET_ACCESS_KEY]" \
    -e AWS_DEFAULT_REGION="[YOUR_AWS_DEFAULT_REGION]" \
    teochenglim/helm-kubectl-aws bash

## ECR Login
$ $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)
```
