resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name}"
  }
}

# External Route Table
resource "aws_route_table" "external_rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "external-${replace(element(split("-", data.aws_availability_zones.available.names[count.index]),2), "/[0-9]/", "")}"
  }
}

resource "aws_route" "external_route_1" {
  route_table_id = "${aws_route_table.external_rt.*.id[0]}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "external_rta" {
  subnet_id = "${aws_subnet.external_subnet.*.id[0]}"
  route_table_id = "${aws_route_table.external_rt.*.id[0]}"
}

resource "aws_subnet" "internal_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1)}"

  tags {
    Name = "internal-${replace(element(split("-", data.aws_availability_zones.available.names[0]),2), "/[0-9]/", "")}"
  }
}

resource "aws_subnet" "external_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, 100)}"

  tags {
    Name = "external-${replace(element(split("-", data.aws_availability_zones.available.names[0]),2), "/[0-9]/", "")}"
  }
}

