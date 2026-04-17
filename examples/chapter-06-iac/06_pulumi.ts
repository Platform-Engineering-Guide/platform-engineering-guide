import * as aws from "@pulumi/aws";
import * as pulumi from "@pulumi/pulumi";
import * as random from "@pulumi/random";

type Environment = "dev" | "staging" | "production";

interface ServiceDatabaseArgs {
  serviceName: string;
  environment: Environment;
  vpcId: pulumi.Input<string>;
  subnetIds: pulumi.Input<string>[];
  kmsKeyArn: pulumi.Input<string>;
}

const instanceConfig: Record<Environment, { class: string; storage: number; backupRetention: number }> = {
  dev:        { class: "db.t3.micro",  storage: 20,  backupRetention: 1  },
  staging:    { class: "db.t3.small",  storage: 50,  backupRetention: 7  },
  production: { class: "db.r6g.large", storage: 200, backupRetention: 30 },
};

export class ServiceDatabase extends pulumi.ComponentResource {
  public readonly endpoint: pulumi.Output<string>;
  public readonly secretArn: pulumi.Output<string>;

  constructor(name: string, args: ServiceDatabaseArgs, opts?: pulumi.ComponentResourceOptions) {
    super("acme:platform:ServiceDatabase", name, {}, opts);

    const config = instanceConfig[args.environment];

    const password = new random.RandomPassword(`${name}-password`, {
      length: 32,
      special: true,
    }, { parent: this });

    const subnetGroup = new aws.rds.SubnetGroup(`${name}-subnet-group`, {
      subnetIds: args.subnetIds,
      tags: this.commonTags(args),
    }, { parent: this });

    const securityGroup = new aws.ec2.SecurityGroup(`${name}-sg`, {
      vpcId: args.vpcId,
      ingress: [{
        fromPort: 5432,
        toPort: 5432,
        protocol: "tcp",
        // Only allow traffic from within the VPC
        cidrBlocks: ["10.0.0.0/8"],
      }],
      tags: this.commonTags(args),
    }, { parent: this });

    const instance = new aws.rds.Instance(`${name}-instance`, {
      identifier:           `${args.serviceName}-${args.environment}`,
      engine:               "postgres",
      engineVersion:        "16.2",
      instanceClass:        config.class,
      allocatedStorage:     config.storage,
      dbName:               args.serviceName.replace(/-/g, "_"),
      username:             "app_user",
      password:             password.result,
      publiclyAccessible:   false,
      storageEncrypted:     true,
      kmsKeyId:             args.kmsKeyArn,
      backupRetentionPeriod: config.backupRetention,
      backupWindow:         "03:00-04:00",
      maintenanceWindow:    "sun:04:00-sun:05:00",
      monitoringInterval:   60,
      performanceInsightsEnabled: true,
      enabledCloudwatchLogsExports: ["postgresql", "upgrade"],
      deletionProtection:   args.environment === "production",
      dbSubnetGroupName:    subnetGroup.name,
      vpcSecurityGroupIds:  [securityGroup.id],
      tags:                 this.commonTags(args),
    }, { parent: this });

    // Store credentials in Secrets Manager
    const secret = new aws.secretsmanager.Secret(`${name}-credentials`, {
      name: `/${args.environment}/${args.serviceName}/db-credentials`,
      kmsKeyId: args.kmsKeyArn,
      tags: this.commonTags(args),
    }, { parent: this });

    new aws.secretsmanager.SecretVersion(`${name}-credentials-version`, {
      secretId: secret.id,
      secretString: pulumi.interpolate`{
        "host": "${instance.address}",
        "port": "5432",
        "database": "${args.serviceName.replace(/-/g, "_")}",
        "username": "app_user",
        "password": "${password.result}"
      }`,
    }, { parent: this });

    this.endpoint = instance.address;
    this.secretArn = secret.arn;

    this.registerOutputs({ endpoint: this.endpoint, secretArn: this.secretArn });
  }

  private commonTags(args: ServiceDatabaseArgs): Record<string, string> {
    return {
      Service:     args.serviceName,
      Environment: args.environment,
      ManagedBy:   "pulumi",
      CostCentre:  `platform-${args.environment}`,
    };
  }
}
