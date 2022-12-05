# Infrastructure

## AWS Zones
| Region | Availability Zones   |
|--------|----------------------|
| us-east-2|us-east-2a, us-east-2b|
| us-west-1|us-west-1a, us-west-1b|

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
| Ubuntu-Web | EC2 | t3.micro | 3 instances | Deployed to two regions, us-east-2 and us-west-1 |
| udacity-project | VPC | NA | 1 | IPs in multiple AZs |
| udacity-cluster | EKS Cluster | NA | 2 nodes | 2 node replica set |
| udacity-lb-tf | ALB Load Balancer | NA | One in each zone  |  |
| udacity-db-cluster | Aurora MySQL DB Cluseter | db.t2.small | 2 clusters, one in us-east-2 and one in us-west-1 | geo replication is configured between the cluster in zone1 and zone2, each cluster has 2 nodes in the appropriate AZs |

### Descriptions
| Asset     | Description                                              |
|-----------|----------------------------------------------------------|
| Ubuntu-Web (EC2) | EC2s are AWS services that run and manage virtual machines in the AWS cloud.  These paticular EC2 instances are the main VMs that are running our application.|
| udacity-project (VPC) | VPCs enables a logically isolated area of AWS cloud.  This VPC will be used to launch AWS resources, including our EC2s in this virtual network |
| udacity-cluster (EKS) | EKS is the AWS managed Kubernetes control plane.  This cluster is used to run a Highly Available and scalable cluster of services |
| udactiy-lb-tf (ALB)| Load balancers are used to automatically scale capacity based on traffic.  This load balence is used to balance the load between our EC2 intances |
| udacity-db-cluster (rds) | RDS is an AWS managed database service. Our db cluster is based a postgres database platform and is being used to store our application data | 


## DR Plan
### Pre-Steps:
In order to acccomodate our DR plan, we need to ensure our infrastructure is deployed in to different AWS regions and use the appropriate availability zones.  In order to do this using terraform, we will need to:
1) Create a zone2 folder using zone1 folder as a starting point
2) Modify the config.tf file to specify the correct S3 bucket and region to store the terraform state
3) Modify the main.tf file to specify the different AWS region (us-west-1 for example)
4) Modify the ec2.tf file to specify the ami in zone2 to use and also to point to the appropriate vpc
5) Using the AWS CLI find the correct availability zones for the AWS 
6) Set up dabases (RDS) geo repplication by creating RDS modules and configuring appropriately by specifying the replication_source_identifier 
7) Deploy the infrastructure to zone2 using terraform init and then terraform apply

## Steps:
In the event of a database node failure, we can perform a failover to the node that is online.  The general steps to do this would be to:
1) Log in to the AWS console and go to our DB cluster
2) Select the node that is offline, and then in the actions menu select the "failover" option
3) After completing this step the "reader" node will become the "writer node

In the event of a complete database cluster failure, as we have configured geo replication, the database cluster in zone 2 will become our "regional" cluster automatically.  Therefore to get the application functional, will just need to change the application configuration to point to the zone2 database cluster.
