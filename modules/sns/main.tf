resource "aws_sns_topic" "daily_notification" {
  name = "daily-text-message"
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.daily_notification.arn
  protocol  = "sms"
  endpoint  = "+16149479555"  # Replace with your phone number
}