control "cis-aws-foundations-1.9" do
  title "Ensure IAM password policy requires minimum length of 14 or greater"
  desc  "Password policies are, in part, used to enforce password complexity
requirements. IAM password policies can be used to ensure password are at least
a given length. It is recommended that the password policy require a minimum
password length 14."
  impact 0.5
  tag "rationale": "Setting a password complexity policy increases account
resiliency against brute force login attempts."
  tag "cis_impact": ""
  tag "cis_rid": "1.9"
  tag "cis_level": 1
  tag "cis_control_number": ""
  tag "nist": ""
  tag "cce_id": "CCE-78907-3"
  tag "check": "Perform the following to ensure the password policy is
configured as prescribed:

'Via AWS Console

* Login to AWS Console (with appropriate permissions to View Identity Access
Management Account Settings)
* Go to IAM Service on the AWS Console
* Click on Account Settings on the Left Pane
* Ensure 'Minimum password length' is set to 14 or greater.

'Via CLI

'aws iam get-account-password-policy

Ensure the output of the above command includes 'MinimumPasswordLength': 14 (or
higher)"
  tag "fix": "Perform the following to set the password policy as prescribed:

'Via AWS Console

* Login to AWS Console (with appropriate permissions to View Identity Access
Management Account Settings)
* Go to IAM Service on the AWS Console
* Click on Account Settings on the Left Pane
* Set 'Minimum password length' to 14 or greater.
* Click 'Apply password policy'

' Via CLI

' aws iam update-account-password-policy --minimum-password-length 14

'Note: All commands starting with 'aws iam update-account-password-policy' can
be combined into a single command."
end
