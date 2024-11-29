variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    environment = "development"
    owner       = "Antonio Ruiz Rondán"
    project     = "my-azure-iac"
  }
}