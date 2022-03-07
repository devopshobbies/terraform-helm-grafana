## Documentation

* Explore the Terraform for Terraform [CLI](https://www.terraform.io/downloads.html).
* Explore the Nodejs for npm [CLI](https://nodejs.org/en/).
* Explore the Yarn for Yarn [CLI](https://classic.yarnpkg.com/en/docs/install#debian-stable).
* Explore the CDK for cdktf [CLI](https://github.com/hashicorp/terraform-cdk/blob/main/docs/cli-commands.md).


Add your AWS credentials as two environment variables, AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY, replacing AAAAAA with each respective values.
```shell
$ export AWS_ACCESS_KEY_ID=AAAAAA
$ export AWS_SECRET_ACCESS_KEY=AAAAA
```

# typescript-aws-s3bucket

A CDK for Terraform application in TypeScript for VPC configuraiton.

## Usage

Install project dependencies

```shell
yarn install
```

Generate CDK for Terraform constructs for Terraform provides and modules used in the project.

```bash
cdktf get
```

You can now edit the `main.ts` file if you want to modify any code.

```typescript
vim main.ts
import { Construct } from 'constructs';
import { App, TerraformOutput, TerraformStack } from 'cdktf';
import { AwsProvider, S3Bucket } from './.gen/providers/aws';

class MyStack extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name);

    new AwsProvider(this, 'aws', {
      region: 'us-east-1',
    });

    const BUCKET_NAME = 'cdktf-typescript-demo-us-east-1';

    const bucket = new S3Bucket(this, 'aws_s3_bucket', {
      bucket: BUCKET_NAME,
      versioning: [
        {
          enabled: true,
        },
      ],
      serverSideEncryptionConfiguration: [
        {
          rule: [
            {
              applyServerSideEncryptionByDefault: [
                {
                  sseAlgorithm: 'AES256',
                },
              ],
            },
          ],
        },
      ],
      lifecycleRule: [
        { enabled: true, id: 'abort-multipart', prefix: '/', abortIncompleteMultipartUploadDays: 7 },
        { enabled: true, transition: [{ days: 30, storageClass: 'STANDARD_IA' }] },
        { enabled: true, noncurrentVersionTransition: [{ days: 30, storageClass: 'STANDARD_IA' }] },
        { enabled: false, transition: [{ days: 90, storageClass: 'ONEZONE_IA' }] },
        { enabled: false, noncurrentVersionTransition: [{ days: 90, storageClass: 'ONEZONE_IA' }] },
        { enabled: false, transition: [{ days: 365, storageClass: 'GLACIER' }] },
        { enabled: false, noncurrentVersionTransition: [{ days: 365, storageClass: 'ONEZONE_IA' }] },
        { enabled: false, expiration: [{ days: 365 }] },
        { enabled: false, noncurrentVersionExpiration: [{ days: 365 }] },
      ],
      tags: {
        Team: 'Devops',
        Company: 'Your compnay',
      },
      policy: `{
        "Version": "2012-10-17",
        "Statement": [
          {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
              "s3:GetObject"
            ],
            "Resource": [
              "arn:aws:s3:::${BUCKET_NAME}/*"
            ]
          }
        ]
      }`,
    });

    new TerraformOutput(this, 'S3 id', {
      value: bucket.id,
    });

    new TerraformOutput(this, 'S3 arn', {
      value: bucket.arn,
    });
  }
}

const app = new App();
new MyStack(app, 'aws-s3');
app.synth();
```

Compile the TypeScript application

```bash
tsc
```
At this step you can run code with two different way:

# The first way:

Generate Terraform configuration

```bash
cdktf synth
```

The above command will create a folder called `cdktf.out` that contains all Terraform JSON configuration that was generated.

Run Terraform commands

```bash
cd cdktf.out
terraform init
terraform plan
terraform apply
```

# The second way:

Run cdktf commands

```bash
cdktf deploy
```
