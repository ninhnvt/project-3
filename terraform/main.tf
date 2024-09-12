# main.tf

provider "aws" {
  region = "us-east-1"
}

# EKS Cluster
resource "aws_eks_cluster" "example" {
  name     = "my-cluster"
  role_arn  = aws_iam_role.eks_role.arn
  version   = "1.21"

  vpc_config {
    subnet_ids = aws_subnet.subnet[*].id
  }
}

# IAM Role for EKS
resource "aws_iam_role" "eks_role" {
  name = "eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
      },
    ],
  })
}

# ECR Repository
resource "aws_ecr_repository" "example" {
  name = "my-ecr-repo"
}

# CodeBuild Project
resource "aws_codebuild_project" "example" {
  name = "my-codebuild-project"
  source {
    type = "GITHUB"
    location = "https://github.com/<username>/<repo>.git"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
  }
}

# CodePipeline
resource "aws_codepipeline" "example" {
  name     = "my-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.bucket.bucket
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name             = "GitHub"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner  = "<username>"
        Repo   = "<repo>"
        Branch = "main"
        OAuthToken = "<github-oauth-token>"
      }
    }
  }
  stage {
    name = "Build"
    action {
      name             = "CodeBuild"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = aws_codebuild_project.example.name
      }
    }
  }
}

# Output EKS Cluster Name
output "eks_cluster_name" {
  value = aws_eks_cluster.example.name
}
