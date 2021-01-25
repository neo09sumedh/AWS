output "aws_iam_role" {
  description = "I AM role created"
  value       = aws_iam_role.iam_for_lambda.arn
}


output "lambdadate" {
  description = "lambda function to display date"
  value       = aws_lambda_function.lambdadate.arn
}

	
