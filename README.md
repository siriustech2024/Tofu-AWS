# Titan

## Overview

Titan is an Infrastructure as Code (IaC) project that provisions a complete AWS environment using [OpenTofu](https://opentofu.org/) (Terraform alternative) and deploys a managed Kubernetes cluster (EKS) with supporting networking resources. It also provides a sample Kubernetes deployment for testing and demonstration.

---

## Features
- Automated AWS VPC provisioning
- Managed EKS (Elastic Kubernetes Service) cluster setup
- Modular, reusable Terraform code (OpenTofu compatible)
- Dockerfile for consistent IaC tooling
- Example Kubernetes deployment and service (nginx)

---

## Prerequisites
- [AWS account](https://aws.amazon.com/)
- [OpenTofu](https://opentofu.org/) or [Terraform](https://www.terraform.io/) CLI (>= 1.3.2)
- AWS credentials configured (via environment variables or AWS CLI)
- [Docker](https://www.docker.com/) (optional, for containerized IaC)

---

## Project Structure

```
Tofu/
  IaC/           # Infrastructure as Code (OpenTofu/Terraform)
    main.tf      # VPC and networking
    eks-al2023.tf# EKS cluster and node group
    backend.tf   # Remote state backend (HTTP, configure as needed)
    version.tf   # Required versions
  docker/        # Dockerfile for IaC tooling
K8s/
  hello_world.yml# Example Kubernetes deployment (nginx)
```

---

## Infrastructure Setup

### 1. Configure Backend (Optional)
Edit `Tofu/IaC/backend.tf` to set up your preferred remote state backend. By default, it uses an empty HTTP backend block.

### 2. Initialize and Apply IaC
You can use either OpenTofu or Terraform CLI. Example with OpenTofu:

```sh
cd Tofu/IaC
# Initialize providers and modules
opentofu init
# Review the plan
opentofu plan
# Apply the infrastructure (creates VPC, EKS, etc.)
opentofu apply
```

> **Note:** The default region is `us-east-1`. You can change it in `main.tf` under `locals`.

---

## Using Docker for IaC
A Dockerfile is provided for a consistent environment:

```sh
cd Tofu/docker
# Build the Docker image
docker build -t titan-tofu .
# Run the container, mounting your AWS credentials and project
# (adjust paths as needed)
docker run --rm -it \
  -v ~/.aws:/root/.aws \
  -v $(pwd)/../IaC:/workspace \
  titan-tofu
# Inside the container:
cd /workspace
opentofu init
opentofu apply
```

---

## Example: Deploying to Kubernetes
After the EKS cluster is created, you can deploy the sample nginx app:

1. [Configure kubectl for your new EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html):
   ```sh
   aws eks --region us-east-1 update-kubeconfig --name titan-cluster
   ```
2. Apply the example manifest:
   ```sh
   kubectl apply -f K8s/hello_world.yml
   ```
3. Get the service's external IP:
   ```sh
   kubectl get svc nginx-service
   ```

---

## Connecting to EKS Cluster from AWS Console

You can also connect to your EKS cluster using the AWS Management Console:

1. **Open the AWS Console:**
   - Go to [https://console.aws.amazon.com/eks/home](https://console.aws.amazon.com/eks/home).
   - Select the region where you deployed the cluster (default: `us-east-1`).

2. **Find Your Cluster:**
   - In the EKS dashboard, locate your cluster (default name: `titan-cluster`).
   - Click on the cluster name to view its details.

3. **Access Cluster Connection Info:**
   - In the cluster details, you will find the command to update your kubeconfig for `kubectl` access. It looks like:
     ```sh
     aws eks --region us-east-1 update-kubeconfig --name titan-cluster
     ```
   - You can copy and run this command in your terminal to configure `kubectl` to connect to your EKS cluster.

4. **Explore Resources:**
   - Use the AWS Console to view nodes, workloads, networking, and other cluster resources.
   - You can also manage IAM roles, authentication, and add-ons from the console.

> **Tip:** The AWS Console provides a visual overview and management options, but for advanced operations, use `kubectl` or automation scripts.

---

## Customization
- **Region:** Change in `Tofu/IaC/main.tf` (`locals { region = ... }`)
- **Cluster size:** Edit `min_size`, `max_size`, and `desired_size` in `eks-al2023.tf`
- **Node type:** Change `instance_types` in `eks-al2023.tf`

---

## Cleanup
To destroy all resources:
```sh
opentofu destroy
```

---

## License
Specify your license here.

---

## Authors
- Denis Abreu

---

## Support & Contributions
Feel free to open issues or submit merge requests!
