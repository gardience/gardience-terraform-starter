terraform {
  required_version = ">= 1.5"
  required_providers {
    gardience = {
      source  = "gardience/gardience"
      version = "~> 0.2"
    }
  }
}

# Reads GARDIENCE_URL, GARDIENCE_API_KEY (a configure key) and, for a private CA, GARDIENCE_CA_CERT_FILE.
provider "gardience" {}
