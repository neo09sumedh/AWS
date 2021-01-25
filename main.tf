provider "aws" {
                access_key = var.key
                secret_key = var.skey
                region = "us-east-1"
}

data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "lambdadate.py"
    output_path   = "lambdadata.zip"
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" 
  ])
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = each.value
}

resource "aws_lambda_function" "lambdadate" {
  filename         = "lambdadata.zip"
  function_name    = "lambdadate"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambdadate.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"
  
  environment {
    variables = {
      DB_HOST = "abcd.asmb.com"
      DB_USER = "Sumedh"
      DB_PASS = "Test321"
    }
  }
  
}
