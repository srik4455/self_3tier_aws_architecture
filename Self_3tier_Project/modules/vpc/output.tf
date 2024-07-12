output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public.*.id
}

output "private_subnet_id" {
  value = aws_subnet.private.*.id
}

output "db_subnet_id" {
  value = aws_subnet.db.*.id

}
