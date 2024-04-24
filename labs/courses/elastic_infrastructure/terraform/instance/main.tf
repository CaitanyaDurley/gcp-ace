resource "google_compute_instance" "vm_instance" {
    # Input variable so can use the module for multiple instances
    name = "${var.instance_name}"
    zone = "${var.instance_zone}"
    machine_type = "${var.instance_type}"
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-11"
        }
    }
    network_interface {
      network = "${var.instance_network}"
      access_config {
        # Empty configuration defaults to an ephemeral external IP
        # Removing the access_config block would mean internal IP only
      }
    }
}
