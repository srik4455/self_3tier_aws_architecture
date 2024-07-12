project_name           = "AWS_3tier_Application"
my_vpc_cidr            = "10.0.0.0/16"
my_vpc                 = "my_vpc"
my_public_subnet       = ["webserver1", "webserver2"]
my_public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
my_private_subnet      = ["appserver1", "appserver2"]
my_private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
my_db_subnet           = ["dbserver1", "dbserver2"]
my_db_cidr             = ["10.0.5.0/24", "10.0.6.0/24"]

