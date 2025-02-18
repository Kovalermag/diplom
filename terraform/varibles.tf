variable "project_id" {
  description = "GCP Project ID"
  default     = "melodic-map-449216-k9"
  type        = string
  }

variable "region" {
  description = "GCP Region"
  default     = "europe-central2"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  default     = "europe-central2-a"
  type        = string
}

variable "google_credentials_path" {
  default = "./melodic-map.json"
}

variable "ssh_private_key_path" {
  description = "Path to the private SSH key"
  default     = "/mnt/c/Users/Mi/.ssh/id_rsa" 
}