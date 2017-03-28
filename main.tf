provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source = "github.com/mario21ic/terraform-aws-vpc-subnets-public-private"

  region = "${var.region}"
  name = "${var.name}"

  vpc_cidr = "${var.vpc_cidr}"

  sn_public_1_cidr = "${var.vpc_sn_public_1_cidr}"
  sn_public_1_az = "${var.vpc_sn_public_1_az}"
  sn_private_1_cidr = "${var.vpc_sn_private_1_cidr}"
  sn_private_1_az = "${var.vpc_sn_private_1_az}"

  sn_public_2_cidr = "${var.vpc_sn_public_2_cidr}"
  sn_public_2_az = "${var.vpc_sn_public_2_az}"
  sn_private_2_cidr = "${var.vpc_sn_private_2_cidr}"
  sn_private_2_az = "${var.vpc_sn_private_2_az}"
}

module "elb" {
  source = "github.com/mario21ic/terraform-aws-elb"

  region = "${var.region}"
  name = "${var.name}"

  vpc_id = "${module.vpc.id}"

  public_subnets        = "${list("${module.vpc.public_subnet_1_id}", "${module.vpc.public_subnet_2_id}")}"
//  public_subnets = "${var.elb_public_subnets}"
}
