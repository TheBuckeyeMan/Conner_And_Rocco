resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "daily-sns-trigger"
  schedule_expression = "cron(0 12 * * ? *)"  # Runs every day at 12:00 UTC
}

resource "aws_cloudwatch_event_target" "send_text_target" {
    rule      = aws_cloudwatch_event_rule.daily_trigger.name
    arn       = data.aws_sns_topic.daily_notification.arn
    role_arn  = data.aws_iam_role.eventbridge_role.arn

    input = jsonencode({
        "Message" = "Hi Rocco, Conner, Im Alexa on AWS (The Cloud). Adam has programmed me to send a friendly reminder that the Ohio State Buckeyes are 0-4 vs Michigan in the last four years. Also, let's get shakers sometime soon!"
    })
}