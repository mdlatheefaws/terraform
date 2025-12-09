resource "aws_instance" "master" {
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type_master
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = var.ssh_key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = file("${path.module}/master_user_data.sh")
  tags = { Name = "k8s-master-${var.name_suffix}" }
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = var.ubuntu_ami
  instance_type          = var.instance_type_worker
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
  key_name               = var.ssh_key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = templatefile("${path.module}/worker_user_data.sh.tpl", { bucket = aws_s3_bucket.join_bucket.bucket })
  tags = { Name = "k8s-worker-${count.index}-${var.name_suffix}" }
}
