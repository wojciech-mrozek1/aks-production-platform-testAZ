locals {
  prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      project = var.project_name
      env     = var.environment
    }
  )
}