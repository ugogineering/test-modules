# Primary clusters
resource "google_container_cluster" "primary" {
  name = "my-gke-cluster"
  location = var.zone
  remove_default_node_pool = true
  initial_node_count = 1
  deletion_protection = false
}