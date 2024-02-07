# Primary clusters
resource "google_container_cluster" "primary" {
  name = "my-gke-cluster"
  location = var.zone
  remove_default_node_pool = true
  initial_node_count = 1
  deletion_protection = false
}

resource "google_container_node_pool" "primary_nodes" {
  name = "my-node-pool"
  location = var.zone
  project = var.project_id
  cluster = google_container_cluster.primary.name 
  node_count = 1

  node_config {
    preemptible = false
    machine_type = "e2-medium"
  }
}