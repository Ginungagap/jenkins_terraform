provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "production" {
 name         = "production"
 machine_type = var.machine_type
 zone         = var.zone
 tags         = ["prod-8081", "http-server"]

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  metadata = {
    ssh-keys = "Gin:${file(var.public_key_path)}"
  }

  metadata_startup_script = ""
  
  network_interface {
    network = var.network
    network_ip = var.network_ip
    access_config {
    }
  }
}


resource "google_compute_instance" "mongo-db" {
 name         = "mongo-db"
 machine_type = var.machine_type
 zone         = var.zone
 tags         = ["mongo-db"]

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  metadata = {
    ssh-keys = "Gin:${file(var.public_key_path)}"
  }

  metadata_startup_script = ""
  
  network_interface {
    network = var.network
    network_ip = var.network_ip
    access_config {
    }
  }
}


resource "null_resource" "mongo-db-provisioner" {
 
  connection {
    user = "Gin"
    host = "${google_compute_instance.mongo-db.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  } 

  provisioner "file" {
    source      = "scenario_mongo.sh"
    destination = "~/scenario_mongo.sh"
  }

  provisioner "remote-exec" {
    inline = [
      #"export MONGO_NETWORK_IP=${var.network_ip}",
      "chmod +x ~/scenario_mongo.sh",
      "sudo ~/scenario_mongo.sh ${google_compute_instance.mongo-db.network_interface.0.network_ip}",
    ]
  }
}


resource "null_resource" "production-provisioner" {
 
  connection {
    user = "Gin"
    host = "${google_compute_instance.production.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  }

  provisioner "file" {
    source      = "scenario_production.sh"
    destination = "~/scenario_production.sh"
  }

  provisioner "file" {
    //source      = "./.ssh/ssh-key.pub"
    source      = "/var/lib/jenkins/.ssh/jenkins.pub"
    //destination = "/tmp/ssh-key.pub"
    destination = "/tmp/jenkins.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scenario_production.sh",
      "sudo ~/scenario_production.sh ${var.network_ip_mongo}",
    ]
  }
}
