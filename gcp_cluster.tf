provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
}

#-----------------Create master node---------------
resource "google_compute_instance" "vm_master" {
  name         = "master"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  provisioner "file" {
    source      = "${var.source_pub_key_dir}"
    destination = "${var.destination_pub_key_dir}"

    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "${var.user}"
      private_key = "${file("${var.path_to_private_key}")}"
    }
  }

  provisioner "file" {
    source      = "setup_kubespray.sh"
    destination = "${var.script_dir}"

    connection {
      type        = "ssh"
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = "${var.user}"
      private_key = "${file("${var.path_to_private_key}")}"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-key}"
  }
}

#-----------------Create worker node---------------
resource "google_compute_instance" "vm_worker1" {
  name         = "worker1"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-key}"
  }
}

#-----------------Create worker node---------------
resource "google_compute_instance" "vm_worker2" {
  name         = "worker2"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "${var.ssh-user}:${var.ssh-key}"
  }
}
