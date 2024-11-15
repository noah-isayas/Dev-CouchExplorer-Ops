terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
  }

  backend "s3" {
    bucket = "pgr301-2024-terraform-state"
    key    = "dev-couch-explorer.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_sqs_queue" "image_requests_queue" {
  name                       = "image-requests-queue"
  visibility_timeout_seconds = 30
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role_kn3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action   = ["s3:PutObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      {
        Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
        Effect   = "Allow"
        Resource = aws_sqs_queue.image_requests_queue.arn
      },
      {
        Action   = ["bedrock:InvokeModel"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "image_generator_lambda" {
  filename         = "lambda_sqs.zip"
  function_name    = "image-generator-sqs-kn3"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda_sqs.lambda_handler"
  runtime          = "python3.9"
  memory_size      = 256
  timeout          = 60
  source_code_hash = filebase64sha256("lambda_sqs.zip")

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
      CANDIDATE_NUMBER = var.candidate_number
    }
  }

  depends_on = [aws_iam_role_policy.lambda_policy]
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.image_requests_queue.arn
  function_name    = aws_lambda_function.image_generator_lambda.arn
  batch_size       = 10
}
