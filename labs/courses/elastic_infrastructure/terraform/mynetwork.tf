resource "google_compute_network" "mynetwork" {
    name = "mynetwork"
    auto_create_subnetworks = "true"
    # other resource properties can go here
}

resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
    name = "mynetwork-allow-http-ssh-rdp-icmp"
    # this firewall rule depends on its network, so we use a reference to instruct
    # terraform to resolve these resources in a dependent order - network before firewall rule
    network = google_compute_network.mynetwork.self_link
    allow {
        protocol = "tcp"
        ports = ["22", "80", "3389"]
    }
    allow {
        protocol = "icmp"
    }
    source_ranges = ["0.0.0.0/0"]
}
