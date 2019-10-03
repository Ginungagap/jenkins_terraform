variable "credentials" {
  description = "CREDENTIALS_JSON_PATH"
  default = "/var/lib/jenkins/credentials/project-for-terraform.json"
  //default = "project-for-terraform.json"
}

variable "project" {
  description = "Project ID"
  default     = "project-for-terraform"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "zone" {
  description = "Zone"
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "Machine type to create"
  default     = "g1-small"
}

variable "disk_image" {
  description = "Centos-7"
  default     = "centos-7-v20190905"
}

variable "public_key_path" {
  description = "Path to the ssh public key"
  default     = "/var/lib/jenkins/.ssh/jenkins.pub"
  //default     = "./.ssh/ssh-key.pub"
}

variable "private_key_path" {
  escription = "Path to the ssh private key"
  default     = "/var/lib/jenkins/.ssh/jenkins"
  //default     = "./.ssh/ssh-key"
}

variable "network" {
  description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
  default     = "default"
}

variable "network_ip" {
  description = "The private IP address to assign to the instance. If empty, the address will be automatically assigned."
  default     = ""
}

variable "network_ip_mongo" {
  description = "local ip mongo db"
  default     = ""
}
