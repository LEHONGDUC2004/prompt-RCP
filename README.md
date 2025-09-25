# prompt-RCP

A cloud infrastructure project using AWS CloudFormation, Step Functions, and related services.

## 🚀 Environment Setup

This project supports multiple environments: `dev`, `staging`, and `prod`.

### Prerequisites

- Python 3.8+
- AWS CLI configured with appropriate credentials
- PowerShell (for Windows deployment scripts)

### 1. Python Environment Setup

Create and activate a virtual environment:

```powershell
# Create virtual environment
python -m venv .venv

# Activate virtual environment
.venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt
```

### 2. Environment Configuration

Copy the example environment file and configure for your needs:

```powershell
# Copy example environment file
cp .env.example .env.dev
```

Edit `.env.dev`, `.env.staging`, or `.env.prod` with your specific configuration:

- **AWS_REGION**: Your preferred AWS region
- **AWS_PROFILE**: AWS CLI profile to use
- **PROJECT_NAME**: Unique project name (will be used as prefix for resources)
- **CF_STACK_NAME**: CloudFormation stack name
- **PRICE_CLASS**: CloudFront price class (PriceClass_100, PriceClass_200, PriceClass_All)
- **CREATE_WAF**: Whether to create WAF (true/false)

### 3. AWS CLI Configuration

Ensure AWS CLI is configured:

```powershell
# Configure default profile
aws configure

# Or configure specific profiles for different environments
aws configure --profile staging
aws configure --profile production
```

## 🛠️ Deployment

### Quick Deployment

Deploy to development environment:

```powershell
# Deploy full infrastructure to dev
.\scripts\deploy.ps1 -Environment dev

# Deploy only Step Function
.\scripts\deploy.ps1 -Environment dev -StepFunctionOnly

# Check deployment status
.\scripts\deploy.ps1 -Environment dev -Action status
```

### Individual Component Deployment

Deploy specific components:

```powershell
# Deploy main CloudFormation stack
.\scripts\deploy-cloudformation.ps1 -Environment dev

# Deploy Step Function
.\scripts\deploy-stepfunction.ps1 -Environment dev
```

### Environment Management

```powershell
# Check environment status
.\scripts\check-status.ps1 -Environment dev

# Cleanup environment (with confirmation)
.\scripts\cleanup-environment.ps1 -Environment dev

# Force cleanup (no confirmation)
.\scripts\cleanup-environment.ps1 -Environment dev -Force
```

## 🏗️ Architecture

This project includes:

- **CloudFront Distribution**: Content delivery network
- **API Gateway**: HTTP API for serverless functions
- **Lambda Functions**: Serverless compute
- **DynamoDB**: NoSQL database
- **S3 Bucket**: Static asset storage
- **Step Functions**: Workflow orchestration
- **WAF** (optional): Web application firewall

## 📁 Project Structure

```
prompt-RCP/
├── cloudformation.yaml          # Main infrastructure template
├── aws-stepfunction/
│   └── stepfunction.yaml       # Step Function definition
├── scripts/                    # Deployment scripts
│   ├── deploy.ps1              # Main deployment script
│   ├── deploy-cloudformation.ps1
│   ├── deploy-stepfunction.ps1
│   ├── check-status.ps1
│   ├── cleanup-environment.ps1
│   └── env_loader.py           # Environment variable loader
├── .env.example               # Environment template
├── .env.dev                   # Development environment
├── .env.staging               # Staging environment
├── .env.prod                  # Production environment
├── requirements.txt           # Python dependencies
└── README.md                  # This file
```

## 🔧 Environment Variables

Key environment variables used:

| Variable        | Description                  | Example              |
| --------------- | ---------------------------- | -------------------- |
| `AWS_REGION`    | AWS region for deployment    | `us-east-1`          |
| `PROJECT_NAME`  | Project prefix for resources | `rcp-mini-dev`       |
| `CF_STACK_NAME` | CloudFormation stack name    | `rcp-mini-dev-stack` |
| `PRICE_CLASS`   | CloudFront price class       | `PriceClass_200`     |
| `CREATE_WAF`    | Enable WAF protection        | `true`/`false`       |

## 🧪 Testing and Validation

```powershell
# Validate CloudFormation templates
aws cloudformation validate-template --template-body file://cloudformation.yaml
aws cloudformation validate-template --template-body file://aws-stepfunction/stepfunction.yaml

# Lint CloudFormation templates
cfn-lint cloudformation.yaml
cfn-lint aws-stepfunction/stepfunction.yaml
```

## 📝 Best Practices

1. **Environment Isolation**: Always use separate AWS accounts or regions for prod
2. **Resource Naming**: Use consistent prefixes for easy resource identification
3. **Security**: Enable WAF for staging and production environments
4. **Monitoring**: Check CloudWatch logs and metrics regularly
5. **Cleanup**: Remove unused environments to avoid unnecessary costs

## 🔍 Troubleshooting

### Common Issues

1. **Stack already exists**: Use update instead of create, or delete the existing stack
2. **Permission denied**: Ensure your AWS credentials have sufficient permissions
3. **Resource conflicts**: Check for naming conflicts with existing resources
4. **Region availability**: Some services may not be available in all regions

### Debug Commands

```powershell
# Check CloudFormation events
aws cloudformation describe-stack-events --stack-name rcp-mini-dev-stack

# View stack resources
aws cloudformation list-stack-resources --stack-name rcp-mini-dev-stack

# Check deployment status
.\scripts\deploy.ps1 -Environment dev -Action status
```

## 🤝 Contributing

1. Create a new branch for your feature
2. Test in the dev environment first
3. Update documentation as needed
4. Create a pull request

## 📄 License

See LICENSE file for details.
