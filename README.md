# AWS_WebInfrastructure
![project2](https://github.com/babnerab/AWS_WebInfrastructure/assets/67218426/7595a036-eae0-4143-8256-7c13556ef9ee)

**Description**

This code is written using HashiCorp Configuration Language (HCL) and is used to provision infrastructure on AWS using Terraform. Let's go through the code step by step to understand what it does:

* The code starts by configuring the AWS provider with the specified region using the `aws` block.

* The next section retrieves the list of availability zones (AZs) in the current AWS region and stores the data in the `aws_availability_zones` and `aws_region` data blocks.

* The code then defines a Virtual Private Cloud (VPC) resource using the `aws_vpc` block. It specifies the CIDR block for the VPC and assigns tags to it for identification and organization.

* Next, the code deploys private subnets using the `aws_subnet` resource block. It uses a loop (`for_each`) to iterate over the `var.private_subnets` variable, which contains a map of subnet names and their corresponding values. Each private subnet is associated with the VPC defined earlier, and the CIDR block for each subnet is calculated using the `cidrsubnet` function. The availability zone for each subnet is determined using the `data.aws_availability_zones.available` data source. Tags are assigned to each subnet for identification.

* Similarly, the code deploys public subnets using the `aws_subnet` resource block. The process is similar to the private subnets, except that the CIDR block for each public subnet is calculated by adding 100 to the corresponding value from `var.public_subnets`. Additionally, the `map_public_ip_on_launch` attribute is set to `true` to enable public IP assignment to instances launched in these subnets.

* Route tables are created for both public and private subnets using the `aws_route_table` resource block. The public route table allows traffic with a destination CIDR block of "0.0.0.0/0" to be routed through the internet gateway. The private route table is set up to route traffic with a destination CIDR block of "0.0.0.0/0" through a NAT gateway.

* Route table associations are established using the `aws_route_table_association` resource block. This associates each public and private subnet with their respective route tables.

* An internet gateway is created using the `aws_internet_gateway` resource block and associated with the VPC.

* An Elastic IP (EIP) is allocated for the NAT gateway using the `aws_eip` resource block. It is associated with the internet gateway defined earlier.

* A NAT gateway is created using the `aws_nat_gateway` resource block. It is associated with the public subnets and uses the allocated EIP.

* The code then uses the `data` block to retrieve the latest Ubuntu 20.04 AMI image ID from AWS.

* EC2 instances are provisioned in both public and private subnets using the `aws_instance` resource blocks. The instances use the retrieved AMI ID and are assigned the specified instance types and subnet IDs.

* Finally, the code includes examples of creating an AWS Key Management Service (KMS) key and an S3 bucket with server-side encryption enabled using the KMS key.

This code essentially creates a VPC with public and private subnets, configures route tables, provisions EC2 instances, and sets up encryption for an S3 bucket using Terraform and the AWS provider.
