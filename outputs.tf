output "aws_vpc.vpc.id" {
  description = "AWS ID of VPC"
  value = "${aws_vpc.vpc.id}"
}

output "aws_vpc.vpc.name" {
  description = "name of VPC"
  value = "${var.vpc_name}"
}

output "aws_vpc.vpc.cidr" {
  description = "cidr block of VPC"
  value = "${var.cidr_block}"
}

output "aws_subnet.internal_subnet.*.id" {
  description = "list containing internal subnet IDs"
  value = ["${aws_subnet.internal_subnet.*.id}"]
}

output "aws_subnet.internal_subnet.*.cidr_block" {
  description = "list containing internal cidr blocks"
  value = ["${aws_subnet.internal_subnet.*.cidr_block}"]
}

output "aws_subnet.external_subnet.*.id" {
  description = "list containing external subnet IDs"
  value = ["${aws_subnet.external_subnet.*.id}"]
}

output "aws_subnet.external_subnet.*.cidr_block" {
  description = "list containing external cidr blocks"
  value = ["${aws_subnet.external_subnet.*.cidr_block}"]
}