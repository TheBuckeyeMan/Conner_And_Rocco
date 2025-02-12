data "aws_iam_role" "eventbridge_role"{
    name = "eventbridge-sns-role"
}

data "aws_sns_topic" "daily_notification" {
    name = "daily-text-message"
}