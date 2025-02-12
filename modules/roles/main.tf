resource "aws_iam_role" "eventbridge_role" {
  name = "eventbridge-sns-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "sns_publish_policy" {
  name        = "EventBridgeSNSPublishPolicy"
  description = "Allows EventBridge to publish messages to SNS"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sns:Publish"
      Resource = data.aws_sns_topic.daily_notification.arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_sns_policy" {
  policy_arn = aws_iam_policy.sns_publish_policy.arn
  role       = aws_iam_role.eventbridge_role.name
}