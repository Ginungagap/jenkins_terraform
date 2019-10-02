output "network_ip_mongo" {
  depends_on = ["null_resource.mongo-db-provider"]
  value = "${google_compute_instance.mongo-db.network_interface.0.network_ip}"
}

output "network_ip_production" {
  value = "${google_compute_instance.production.network_interface.0.network_ip}"
}