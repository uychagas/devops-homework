output "namespace" {
  value       = helm_release.application.namespace
  description = "Kubernetes namespace where the Helm release was installed."
}

output "name" {
  value       = helm_release.application.name
  description = "Release name given to the Helm deployment."
}

output "chart" {
  value       = helm_release.application.chart
  description = "Path or chart reference used for the Helm release (local path or chart identifier)."
}

output "revision" {
  value       = helm_release.application.metadata.revision
  description = "Helm release revision number representing the current revision of the deployed chart."
}

output "notes" {
  value       = helm_release.application.metadata.notes
  description = "Release notes returned by Helm after install/upgrade (may contain helpful instructions or URLs)."
}