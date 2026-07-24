variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "common_tags" {
  description = "Common Tags"
  type        = map(string)
}
