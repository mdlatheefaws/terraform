resource "aws_s3_bucket" "join_bucket" {
  bucket = "kubeadm-join-${var.name_suffix}-${random_id.bucket_suffix.hex}"
  acl    = "private"

  tags = { Name = "kubeadm-join-${var.name_suffix}" }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "k8s-ec2-role-${var.name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

data "aws_iam_policy_document" "ec2_s3_policy" {
  statement {
    sid    = "AllowS3GetPut"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.join_bucket.arn,
      "${aws_s3_bucket.join_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name   = "k8s-ec2-s3-policy-${var.name_suffix}"
  policy = data.aws_iam_policy_document.ec2_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "k8s-instance-profile-${var.name_suffix}"
  role = aws_iam_role.ec2_role.name
}
