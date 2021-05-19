# Hello world docker action

Control your EKS cluster via `kubectl` in a Github Action

## Configuration

### Create Secrets
This GitHub Action requires the following GitHub secrets to exist:

For AWS CLI:     
AWS_ACCESS_KEY_ID,    
AWS_SECRET_ACCESS_KEY,    
AWS_REGION

For kubectl
KUBE_CONFIG_DATA_BASE_64_ENCODED

for `KUBE_CONFIG_DATA_BASE_64_ENCODED`
1. Create a working .kube config for your cluster
1. base64 encoude the file at `$~/.kube/config`
```sh
$ cat ~/.kube/config | base64 > KUBE_CONFIG_DATA_BASE_64_ENCODED.txt
```
create a GithHub secret named: `KUBE_CONFIG_DATA_BASE_64_ENCODED` and paste the content of `KUBE_CONFIG_DATA_BASE_64_ENCODED.txt`

### Example Yaml

```yaml
jobs:
  jobName:
    name: Push Latest Container image
    runs-on: ubuntu-latest
    steps:
      - name: Deploy new docker image
        uses: gjyoung1974/aws-eks-kubectl
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_REGION: ${{ secrets.AWS_REGION }}
          KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA_BASE_64_ENCODED }}
        with:
          args: set image --record deployment/pod-name pod-name=DOCKER_IMAGE_URL
```
2021 - opensource@lemonaid.com
