# myprojectnginx

I have developed Devops solution and stored in github 
Please use below github URL and clone to access code

 https://github.com/manyampvs/myprojectnginx.git

Note: Due to the POC project and for security reasons I have masked key value pairs. To execute this project I hope you can use your own key values. 

Solution description

As per provided problem statement document (requirement specification) I have prepared pipelines and hosted on AWS VM

AWS cloud application can be accessible through internet using below load balancer DNS URL

http://myproject-ec2-alb-2016379717.ap-southeast-1.elb.amazonaws.com/

Using GItlab YAML file I  have defined two stages

Stage 1 Retrieved CIDR. 
stage 2 Creating infrastructure and deploying the nginx web server as a docker container.

Using terraform I have created the subnets AWS SSH key pair and defined the infrastructure and it includes VPC, subnets, Internet gateway , NAT gateway , Security groups, IAM role, Application Load balancer , and also configured nginx web server in resilience and high availability architecture through AWS auto scaling feature. 

I have deployed a nginx web server as a Docker container. 

We can leverage cloud metrics / logging for error handling by integrating CloudWatch or we can integrate centralized logging tools like SPLUNK or ELK. We can achieve this by deploy Splunk, plug-in as an agent. Similarly, we can use and deploy fluent-D as a container and push to the central logging system like SPLUNK or ELK etc. 
