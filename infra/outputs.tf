output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.image_generator_lambda.function_name
}

output "sqs_queue_url" {
  description = "URL of the SQS Queue"
  value       = aws_sqs_queue.image_requests_queue.id
}
