provider "aws" {
  region = "ap-south-1"
}

module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.networking.subnet_id
  vpc_id    = module.networking.vpc_id
}

output "public_ip" {
  value = module.ec2.public_ip
}