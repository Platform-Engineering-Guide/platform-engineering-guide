# AWS CDK / Terraform equivalent:
# aws_secretsmanager_rotation_schedule resource
import aws_cdk.aws_secretsmanager as sm

secret = sm.Secret(self, "PaymentsDatabaseSecret",
    secret_name="/production/payments-service/database",
    generate_secret_string=sm.SecretStringGenerator(
        secret_string_template='{"username": "payments_app"}',
        generate_string_key="password",
        exclude_characters=' %+~`#$&*()|[]{}:;<>?!/\\\'"@='
    )
)

# Attach rotation to RDS instance
secret.add_rotation_schedule("Rotation",
    automatically_after=Duration.days(30),
    hosted_rotation=sm.HostedRotation.mysql_single_user(
        vpc=vpc,
        vpc_subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PRIVATE_WITH_EGRESS)
    )
)
