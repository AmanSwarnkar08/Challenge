/*****************************************
  VPC
 *****************************************/
resource "google_compute_network" "network" {
  name                    = format("%s-network", var.cluster_name)
  project                 = var.project_id
  auto_create_subnetworks = false

  depends_on = [

  ]
}

// Create subnets
resource "google_compute_subnetwork" "subnetwork" {
  name          = format("%s-subnet", var.cluster_name)
  project       = var.project_id
  network       = google_compute_network.network.self_link
  region        = var.region
  ip_cidr_range = var.subnet_ip

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = format("%s-pod-range", var.cluster_name)
    ip_cidr_range = "10.2.0.0/16"
  }

  secondary_ip_range {
    range_name    = format("%s-svc-range", var.cluster_name)
    ip_cidr_range = "10.3.0.0/20"
  }
}


/*****************************************
  VPC - Standard Firewalls
 *****************************************/
resource "google_compute_firewall" "default-denyall-ingress" {
  name    = "${var.cluster_name}-deny-ingress-internet"
  network = google_compute_network.network.name
  direction = "INGRESS"
  priority = 65000

  deny {
    ports    = []
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "default-denyall-egress" {
  name    = "${var.cluster_name}-deny-egress-internet"
  network = google_compute_network.network.name
  direction = "EGRESS"
  priority = 65000

  deny {
    ports    = []
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "default-allow-http-egress" {
  name    = "${var.cluster_name}-allow-egress-http-internet"
  network = google_compute_network.network.name
  direction = "EGRESS"
  priority = 64000

  allow {
    ports    = []
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow-internal-ingress" {
  name    = "${var.cluster_name}-allow-ingress-withinvpc"
  network = google_compute_network.network.name
  allow {
    ports    = []
    protocol = "all"
  }
  source_ranges = [
    "${var.subnet_ip}",
  ]
}

resource "google_compute_firewall" "allow-internal-egress" {
  name    = "${var.cluster_name}-allow-egress-withinvpc"
  network = google_compute_network.network.name

  direction = "EGRESS"

  allow {
    ports    = []
    protocol = "all"
  }
  destination_ranges = [
    "${var.subnet_ip}",
  ]
}

resource "google_compute_firewall" "default-allow-iap-ingress" {
  name    = "${var.cluster_name}-allow-ingress-iap"
  network = google_compute_network.network.name
  direction = "INGRESS"
  priority = 20000

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

