terraform {
  required_providers {
    pihole = {
      source = "ryanwholey/pihole"
      version = "~>0.0.12"
      configuration_aliases = [ pihole.main, pihole.backup ]
    }
  }
}