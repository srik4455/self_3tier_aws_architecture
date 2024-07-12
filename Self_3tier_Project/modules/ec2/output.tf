output "web_instances_id" {
  value = aws_instance.web.*.id

}

output "app_instances_id" {
  value = aws_instance.app.*.id

}
output "db_instances_id" {
  value = aws_instance.db.*.id
}
