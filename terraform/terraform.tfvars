# ! ============ main.tf ============
region               = "us-east-1"
aws_credentials_path = "~/.aws/credentials"

# ! ============ ec2.tf ============
instance_type = "t2.micro"
instance_ami  = "ami-0915e09cc7ceee3ab"
instance_name = "hello-terraform"

# ! ============ security_group.tf ============
sg_name         = "sg_terraform"
app_port        = "80"
key_name        = "terraformKey"
public_key_path = "~/.ssh/terraformKey.pub"

