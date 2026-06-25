output "cluster_name" {
  value = var.cluster_name
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_provider" {
  value = module.eks.cluster_oidc_issuer_url
}
