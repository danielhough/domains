provider "aws" {}

variable "APP_NAME" {
  description = "Domains"
  default     = "domains"
}

variable "APP_ENV" {
  description = "Application environment tag"
  default     = "dev"
}

locals {
  app_id = "${lower(var.APP_NAME)}-${lower(var.APP_ENV)}-${random_id.unique_suffix.hex}"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file  = "bin/app"
  output_path = "bin/app.zip"
}

resource "random_id" "unique_suffix" {
  byte_length = 2
}
