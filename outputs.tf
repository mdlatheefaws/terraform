output "public_ip" {
    description = "Public IP addresses of the public EC2 instances"
    #value = { for a, b in aws_instance.demo_instance-pub : a => b.public_ip }
    #value = aws_instance.demo_instance-pub.*.public_ip
    #[for item in item : expression] 
    value = { for name, instance in aws_instance.demo_instance-pub : name => instance.public_ip }
    
  }


