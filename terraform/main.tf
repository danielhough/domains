provider "aws" {
}

variable "app_name" {
  description = "Domains"
  default     = "domains"
}

variable "app_env" {
  description = "Application environment tag"
  default     = "dev"
}

locals {
  app_id = "${lower(var.app_name)}-${lower(var.app_env)}-${random_id.unique_suffix.hex}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file  = "bin/app"
  output_path = "bin/app.zip"
}

resource "random_id" "unique_suffix" {
  byte_length = 2
}
