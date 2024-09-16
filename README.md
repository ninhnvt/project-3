# Microservices AWS Kubernetes Project

This project sets up a microservices architecture on AWS EKS (Elastic Kubernetes Service), which includes a PostgreSQL database and a Python analytics service. It includes configurations and deployment files for both cloud and local environments.

## Project Structure

The project is organized into the following directories and files:

- **`analytics/`**: Contains the Python analytics service.
  - `app.py`: Main application logic.
  - `config.py`: Configuration settings.
  - `requirements.txt`: Python dependencies.

- **`db/`**: SQL scripts for PostgreSQL.
  - `1_create_tables.sql`: SQL script to create database tables.
  - `2_seed_users.sql`: SQL script to seed user data.
  - `3_seed_tokens.sql`: SQL script to seed token data.

- **`deployment/`**: Kubernetes YAML files for cloud deployment.
  - `configmap.yaml`: Configuration for environment variables.
  - `coworking.yaml`: Deployment configuration for the Python analytics service.
  - `postgresql-deployment.yaml`: Deployment configuration for PostgreSQL.
  - `postgresql-service.yaml`: Service definition for PostgreSQL.
  - `pv.yaml`: Configuration for persistent volume.
  - `pvc.yaml`: Configuration for persistent volume claim.
  - `secret-postgresql.yaml`: Configuration for PostgreSQL password.

- **`deployment-local/`**: Local deployment configurations for testing before deploying to AWS.

- **`screen/`**: Screenshots of the deployment process.

- **`buildspec.yaml`**: AWS CodeBuild configuration.

- **`Dockerfile`**: Instructions for building the Docker image for the Python service.

- **`LICENSE.txt`**: License information.

- **`README.md`**: Project documentation.

## Getting Started

### Prerequisites

Make sure you have the following tools installed:

- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Docker](https://www.docker.com/get-started)
- PostgreSQL (for local development)

### Deployment

To deploy the services to your Kubernetes cluster on AWS EKS, use the following command:

```bash
kubectl apply -f deployment/
```

### Local Development

For local testing before deploying to AWS, use the configurations found in the `deployment-local/` directory.

## License

This project is licensed under the MIT License. See the [LICENSE.txt](LICENSE.txt) file for more details.

```

Feel free to adjust any details according to your project's needs or specific instructions!
