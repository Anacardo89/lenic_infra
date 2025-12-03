resource "aws_iam_role" "lenic_app_role" {
  name = "lenic-app-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lenic_s3_read" {
  name = "lenic-s3-read"
  role = aws_iam_role.lenic_app_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:GetObject"]
        Resource = "arn:aws:s3:::lenic-app-configs/*"
      }
    ]
  })
}
