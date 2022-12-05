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
1) Ensure that our infrastructure is deployed in multiple locations.
2) Automate the deployment our our infrastructure to prevent configuration drift
3) DR plan is kept up-to-date and when any infrastructure is added or removed, we update the plan
4) Enable database replication so that our dbs are in-sync and so that we can failover seamlessly in the event of a failure
5) Ensure that **both sites are conficgured the same** in the IaC code

## Steps:
1) Point the DNS to secondary region using Amazon route 53
2) Failover database to secondary region by going in to AWS console and making the secondary region the primary within the RDS service
