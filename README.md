# aws-codebuild-serverless
You can use this Docker image in AWS CodeBuild when you need to package and deploy [Serverless](https://serverless.com/) framework application.

Your code will be "compiled" against the correct version of OS and Node. This is especially important for native addons.

It targets directly Lambda execution environment as described [in the documentation](https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html):

>The underlying AWS Lambda execution environment is based on the following:
> * Public Amazon Linux AMI version (AMI name: amzn-ami-hvm-2017.03.1.20170812-x86_64-gp2) which can be accessed here.
>   For information about using an AMI, see Amazon Machine Images (AMI) in the Amazon EC2 User Guide for Linux Instances.
> * Linux kernel version – 4.9.93-41.60.amzn1.x86_64
>
>If you are using any native binaries in your code, make sure they are compiled against the package and library versions from this AMI and kernel. Note that only 64-bit binaries are supported on AWS Lambda and that the specific CPU make and model is subject to continual updates.
>
>AWS Lambda supports the following runtime versions:
>
> * Node.js – v8.10, v6.10 or v4.3
> ...

## Docker base image
We use `amazonlinux:2017.03.1.20170812` which reflects AWS Lambda execution environment.

## What is installed?
* `gcc-c++` and `make` for native addon compilation
* `node` according to the Docker image tag
* the latest `yarn`
* `serverless` according to the Docker image tag

The `extra` image contains on top of that:
* `git` (2.14.4)
* `unzip`
* the latest `aws-cli` at the time of build

## How is it built?
Dockerfile build is parametrized instead of the usual folder/branch/tag mumbo jumbo. `release.sh` builds all the combinations and pushes them to Docker Hub.
