#### Deploying Halo on AWS Elastic Beanstalk

#### Install the EB CLI

If you have pip, use it to install the EB CLI.

    $ pip install --user --upgrade awsebcli

If you don't have pip, follow the instructions here.

For Mac OSX (using brew):

    brew install awsebcli
    
#### Set up 
Referenced from http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html

```
aws-beanstalk$ eb init

Select a default region
1) us-east-1 : US East (N. Virginia)
2) us-west-1 : US West (N. California)
3) us-west-2 : US West (Oregon)
4) eu-west-1 : EU (Ireland)
5) eu-central-1 : EU (Frankfurt)
6) ap-southeast-1 : Asia Pacific (Singapore)
7) ap-southeast-2 : Asia Pacific (Sydney)
8) ap-northeast-1 : Asia Pacific (Tokyo)
9) ap-northeast-2 : Asia Pacific (Seoul)
10) sa-east-1 : South America (Sao Paulo)
11) cn-north-1 : China (Beijing)
(default is 3):

Enter Application Name
(default is "aws_beanstalk"):

Application aws_beanstalk has been created.

Select a platform.
1) Node.js
2) PHP
3) Python
4) Ruby
5) Tomcat
6) IIS
7) Docker
8) Multi-container Docker
9) GlassFish
10) Go
11) Java
(default is 1): 5

Select a platform version.
1) Tomcat 8 Java 8
2) Tomcat 7 Java 7
3) Tomcat 7 Java 6
4) Tomcat 7
5) Tomcat 6
(default is 1):


Do you want to set up SSH for your instances?
(y/n): y

Select a keypair.
1)
```

#### Halo Configurations (Set the following environment variables)
http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb3-setenv.html to see how to set environment variables

1. AGENT_KEY=agent_key
2. AWS_SERVER_LABEL=0

#### Deploy Halo AWS Beanstalk

1. eb deploy

```
Creating application version archive "app-9566-161206_114744".
Uploading cp_halo/app-9566-161206_114744.zip to S3. This may take a while.
Upload Complete.
INFO: Environment update is starting.
INFO: Deploying new version to instance(s).
INFO: Environment health has transitioned from Ok to Info. Application update in progress (running for 16 seconds).
INFO: New application version was deployed to running EC2 instances.
INFO: Environment update completed successfully.
```

<!---

#CPTAGS:community-supported archive
#TBICON:images/partner-supported.png

-->
