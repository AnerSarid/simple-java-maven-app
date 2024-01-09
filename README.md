# Secure Java CI/CD Pipeline with Docker and AWS

## Description
This project implements a CI/CD pipeline for a simple Java application, emphasizing security with SSL/TLS configurations. Using GitHub Actions, Docker Context, and AWS EC2, the pipeline automates building a Docker image, securely pushing it to Docker Hub, and securely deploying it remotely on an AWS EC2 instance.

## Architecture
The CI/CD pipeline integrates:

- **GitHub Actions**: Automates build and deployment processes.
- **Docker and Docker Context**: Containerizes the Java application and enables secure remote deployment.
- **AWS EC2**: Hosts the Dockerized application, with instances created and managed via Terraform.
- **Terraform**: Manages infrastructure as code, including EC2 instances and security groups.
- **SSL/TLS Encryption**: Ensures secure communication between GitHub Actions and the Docker daemon on the EC2 instance.

## Prerequisites
- Docker with SSL/TLS configuration knowledge.
- An AWS account with a pre-configured AMI containing `ca.crt` and `ca.key` in `/etc/docker/certs`.
- A Docker Hub account.
- Java and Maven for building the Java application.
- Terraform for infrastructure setup.

## Setup and Installation

### GitHub Actions Setup
1. Fork or clone the repository containing the pipeline (`.github/workflows/ci-cd.yml`).
2. Configure GitHub Secrets for your repository:
   - AWS credentials
   - Docker Hub credentials
   - TLS certificates for secure Docker communication

### Docker Hub Configuration
Prepare your Docker Hub account to receive images from the pipeline.

### AWS EC2 and Terraform Configuration
1. Ensure your AWS AMI with `ca.crt` and `ca.key` for SSL/TLS configurations is available.
2. Modify the Terraform module in the project to match your AWS account specifics, including SSH keys and region.

## Usage
After deployment:
- The Java application simply prints "Hello World".
- Use `docker logs [container-name]` on the EC2 instance to view the application output.
- The container is deployed via Docker Context with SSL/TLS encryption for secure communication.

## Security
- The pipeline uses SSL/TLS encryption for secure interactions between GitHub Actions and the Docker daemon on the EC2 instance.
- Terraform scripts include security group configurations ensuring that only necessary ports are open and secure.

## Contributing
Contributions are welcome. To contribute:
1. Fork the repository.
2. Create a new branch for your changes.
3. Submit a pull request.

