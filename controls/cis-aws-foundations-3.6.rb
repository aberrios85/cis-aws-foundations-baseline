control "cis-aws-foundations-3.6" do
  title "Ensure a log metric filter and alarm exist for AWS Management Console
authentication failures"
  desc  "Real-time monitoring of API calls can be achieved by directing
CloudTrail Logs to CloudWatch Logs and establishing corresponding metric
filters and alarms. It is recommended that a metric filter and alarm be
established for failed console authentication attempts."
  impact 0.5
  tag "rationale": "Monitoring failed console logins may decrease lead time to
detect an attempt to brute force a credential, which may provide an indicator,
such as source IP, that can be used in other event correlation."
  tag "cis_impact": ""
  tag "cis_rid": "3.6"
  tag "cis_level": 2
  tag "cis_control_number": ""
  tag "nist": ""
  tag "cce_id": "CCE-79191-3"
  tag "check": "Perform the following to determine if the account is configured
as prescribed: 1. Identify the log group name configured for use with
CloudTrail:


'aws cloudtrail describe-trails
2. Note the <cloudtrail_log_group_name> value associated with
CloudWatchLogsLogGroupArn:


''arn:aws:logs:eu-west-1:<aws_account_number>:log-group:<cloudtrail_log_group_name>:*'

3. Get a list of all associated metric filters for this
<cloudtrail_log_group_name>:


'aws logs describe-metric-filters --log-group-name
'<cloudtrail_log_group_name>'4. Ensure the output from the above command
contains the following:


''filterPattern': '{ ($.eventName = ConsoleLogin) &'><sns_topic_arn> _

"
  tag "fix": "Perform the following to setup the metric filter, alarm, SNS
topic, and subscription:1. Create a metric filter based on filter pattern
provided which checks for AWS Management Console authentication failures and
the <cloudtrail_log_group_name> taken from audit step 2.


'aws logs put-metric-filter --log-group-name <cloudtrail_log_group_name>
--filter-name _<console_signin_failure_metric>_ --metric-transformations
metricName=_<console_signin_failure_metric>_,metricNamespace='CISBenchmark',metricValue=1
--filter-pattern '{ ($.eventName = ConsoleLogin) &'><sns_topic_arn> --protocol
_<protocol_for_sns>_ --notification-endpoint _<sns_subscription_endpoints>_
NOTE: you can execute this command once and then re-use the SNS subscription
for all monitoring alarms.
4. Create an alarm that is associated with the CloudWatch Logs Metric Filter
created in step 1 and an SNS topic created in step 2


'aws cloudwatch put-metric-alarm --alarm-name _<console_signin_failure_alarm>_
--metric-name _<console_signin_failure_metric>_ --statistic Sum --period 300
--threshold 1 --comparison-operator GreaterThanOrEqualToThreshold
--evaluation-periods 1 --namespace 'CISBenchmark' --alarm-actions
<sns_topic_arn>
"
end
