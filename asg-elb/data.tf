// Default vpc
data "aws_subnet_ids" "test_subnet_ids" {
  vpc_id = "vpc-0d9cce260f6f48c31"
}


data "aws_subnet" "test_subnet" {
  count = length(data.aws_subnet_ids.test_subnet_ids.ids)
  id    = tolist(data.aws_subnet_ids.test_subnet_ids.ids)[count.index]
}