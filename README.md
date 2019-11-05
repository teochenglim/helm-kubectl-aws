# helm-kubectl-aws

1. helm + kubectl + awscli docker helper

    ```bash
    $ docker run -it \
        -e AWS_ACCESS_KEY_ID="[YOUR_AWS_ACCESS_KEY_ID]" \
        -e AWS_SECRET_ACCESS_KEY="[YOUR_AWS_SECRET_ACCESS_KEY]" \
        -e AWS_DEFAULT_REGION="[YOUR_AWS_DEFAULT_REGION]" \
        teochenglim/helm-kubectl-aws bash

    ## ECR Login

    $ $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)

    ```

2. For ECR container scanning
https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html

    ```shell
    ## Creating a New Repository to Scan on Push
    aws ecr create-repository --repository-name name \
        --image-scanning-configuration scanOnPush=true --region us-east-2
    ## Configure an Existing Repository to Scan on Push
    aws ecr put-image-scanning-configuration --repository-name name \
        --image-scanning-configuration scanOnPush=true --region us-east-2
    ## Manually Scanning an Image
    aws ecr start-image-scan --repository-name name --image-id \
        imageTag=tag_name --region us-east-2
    ## Retrieving Scan Findings
    aws ecr describe-image-scan-findings --repository-name name \
        --image-id imageTag=tag_name --region us-east-2

    ```

3. FAQ

  * aws ecr doesn't have "describe-image-scan-findings"

  * Patch the awscli not using latest version on homebrew. Homebrew is still using 1.16.260, but pip is at 1.16.273 as per today 5 Nov 2019

    > https://github.com/Homebrew/homebrew-core/blob/master/Formula/awscli.rb

    > https://pypi.org/project/awscli/


      ```shell

      aws ecr help # that's no container scanning methods
      brew uninstall awscli
      sudo pip3 install -U awscli
      ```

  * OpenSSL error with libssl and libcrypto while using pip3
  
    https://someguys.blog/2019-10-09-python-abort-on-macos-catalina/

    1. reinstall openssl with the correct point of dynamic link library. default link to open 1.0.0 but latest is 1.0.2t

    ```shell
    $ ln -s /usr/local/Cellar/openssl/1.0.2t/lib/libcrypto.1.0.0.dylib /usr/local/lib/libcrypto.dylib
    $ ln -s /usr/local/Cellar/openssl/1.0.2t/lib/libssl.1.0.0.dylib /usr/local/lib/libssl.dylib
    $ brew remove openssl
    $ brew install openssl
    ```
