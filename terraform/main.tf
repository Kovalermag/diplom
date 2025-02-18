provider "google" {
  credentials = file(var.google_credentials_path)
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "default" {
  name = "my-network"
}

resource "google_compute_firewall" "default" {
  name    = "allow-http-ssh"
  # network = google_compute_network.default.id
  network = google_compute_network.default.self_link

  allow {
     protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["443", "22", "80", "5044", "5601", "8080", "8081", "9090", "9093", "9100", "9200", "19100"]
  }
  source_ranges = ["0.0.0.0/0"]  
  target_tags = ["http-server", "https-server", "http-server", "lb-health-check"]
}

resource "google_compute_instance" "webserver" {
  name         = "webserver-instance"
  machine_type = "e2-standard-4"
  zone         = var.zone
  tags         = ["https-server", "http-server", "lb-health-check", "jenkins"]
  
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 20
      type  = "pd-standard"
    }
  }

  scheduling {
    preemptible                 = true
    automatic_restart           = false
    provisioning_model          = "SPOT"
    instance_termination_action = "STOP"
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
    }
  }

  metadata = {
    # startup-script = "sudo apt update && sudo apt upgrade -y"
    ssh-keys = "debian:${file("/mnt/c/Users/Mi/.ssh/id_rsa.pub")}"
  }

  # metadata_startup_script = <<-EOF
  #   sudo apt update
  #   sudo apt install python3-pip -y
  #   pip3 install prometheus-client
  #   EOF
}


  resource "local_file" "inventory" {
      content = <<EOT
[web]
${google_compute_instance.webserver.name} ansible_host=${google_compute_instance.webserver.network_interface[0].access_config[0].nat_ip} ansible_user=debian
[elk_servers]
${google_compute_instance.webserver.name} ansible_host=${google_compute_instance.webserver.network_interface[0].access_config[0].nat_ip} ansible_user=debian
EOT
    filename = "../ansible/inventory.ini"
  }