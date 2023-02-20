resource "pihole_dns_record" "main_dns_record" {
  provider  = pihole.main
  domain    = var.domain
  ip        = var.ip
}

resource "pihole_dns_record" "backup_dns_record" {
  provider  = pihole.backup
  domain    = var.domain
  ip        = var.ip
}