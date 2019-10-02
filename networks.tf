resource "google_compute_firewall" "prod-8081" {
  name    = "prod-8081"
  network = var.network

  target_tags = ["prod-8081"]

  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }
}

resource "google_compute_firewall" "mongo-db" {
  name    = "mongo-db"
  network = var.network
    
  target_tags = ["mongo-db"]

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
}