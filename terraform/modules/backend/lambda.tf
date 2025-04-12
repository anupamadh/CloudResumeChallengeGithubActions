# lambda.tf

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "dynamodb_full_access" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/update_count.py"
  output_path = "${path.module}/lambda/update_count.zip"
}

resource "aws_lambda_function" "update_count" {
  function_name    = "update_count"
  filename         = data.archive_file.lambda.output_path
  role             = aws_iam_role.iam_for_lambda.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.12"
  handler          = "update_count.lambda_handler"
  timeout          = 10
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.update_count.function_name
  authorization_type = "NONE"

/*
  cors {
    allow_credentials = true
    allow_origins     = ["https://${aws_cloudfront_distribution.crc_distribution.domain_name}"]
    allow_methods     = ["GET", "POST"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
  */
}