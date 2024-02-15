variable "zone" {
  description = "Default Zone"
  type = string
  default = "us-east1-a"
}
variable "project_id" {
  description = "Project ID"
  type = string 
  default = "myterraformpractice"
}
variable "cluster_name" {
  description = "Cluster name"
  type = string
  default = "gke-cluster" 
}