# GitHub Actions Secrets Template

## Required Secrets

Configure the following secrets in your GitHub repository:

### 1. GitHub Secrets (Automatic)
- `GITHUB_TOKEN` - Automatic GitHub token (already available)

### 2. AWS Secrets
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key
- `AWS_REGION` - AWS region (e.g., us-east-1)

### 3. Optional Secrets
- `DOCKER_USERNAME` - Docker Hub username (if using Docker Hub)
- `DOCKER_PASSWORD` - Docker Hub password (if using Docker Hub)

## How to Configure

1. Go to your repository on GitHub
2. Click on "Settings"
3. Click on "Secrets and variables" → "Actions"
4. Click on "New repository secret"
5. Add each secret with the corresponding name and value

## Configuration Example

```bash
# AWS
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_REGION=us-east-1

# Docker Hub (optional)
DOCKER_USERNAME=your_username
DOCKER_PASSWORD=your_password
```

## Required Permissions

Make sure the repository has the following permissions:

1. **Settings** → **Actions** → **General**
   - ✅ "Allow all actions and reusable workflows"
   - ✅ "Read and write permissions"
   - ✅ "Allow GitHub Actions to create and approve pull requests"

2. **Settings** → **Actions** → **General** → **Workflow permissions**
   - ✅ "Read and write permissions"

## Environments

Configure environments in GitHub:

1. **Settings** → **Environments**
2. Create environments:
   - `staging`
   - `production`

3. For each environment, configure:
   - **Protection rules** (optional)
   - **Environment secrets** (if needed)
   - **Required reviewers** (for production)

## Verification

To verify everything is configured correctly:

1. Run the workflow manually
2. Check logs for authentication errors
3. Test Docker image build
4. Test `tofu plan` 