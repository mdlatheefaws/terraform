output "master_public_ip" {
  value = aws_instance.master.public_ip
}

output "worker_public_ips" {
  value = [for w in aws_instance.worker : w.public_ip]
}

output "join_bucket" {
  value = aws_s3_bucket.join_bucket.bucket
}
