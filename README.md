# aws-codebuild-serverless

This Docker image is intended for use inside AWS CodeBuild when you need to package and deploy [Serverless](https://serverless.com/) framework application.

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

Using this Docker image means your code will be "compiled" against the correct version of OS and Node. This is especially important for native addons.