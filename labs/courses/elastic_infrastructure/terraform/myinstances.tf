module "mynet-us-vm" {
    source = "./instance"
    instance_name = "mynet-us-vm"
    instance_zone = "Zone"
    instance_network = google_compute_network.mynetwork.self_link
}

module "mynet-eu-vm" {
    source = "./instance"
    instance_name = "mynet-eu-vm"
    instance_zone = "Zone 2"
    instance_network = google_compute_network.mynetwork.self_link
}
