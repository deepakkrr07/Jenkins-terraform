provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(
      aws_eks_cluster.main.certificate_authority[0].data
    )

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"

      command = "aws"

      args = [
        "eks",
        "get-token",
        "--cluster-name",
        aws_eks_cluster.main.name
      ]

      # OPTIONAL (recommended for cross-account / CI/CD roles)
      # args = [
      #   "eks", "get-token",
      #   "--cluster-name", aws_eks_cluster.main.name,
      #   "--role-arn", "arn:aws:iam::<account-id>:role/<role-name>"
      # ]
    }


provider "kubernetes" {
  host = aws_eks_cluster.main.endpoint

  cluster_ca_certificate = base64decode(
    aws_eks_cluster.main.certificate_authority[0].data
  )

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"

    command = "aws"

    args = [
      "eks",
      "get-token",
      "--cluster-name",
      aws_eks_cluster.main.name
    ]

    # Optional role assumption (same as above if needed)
  }
}
``
  }
}
