resource "pihole_cname_record" "main_cname_record" {
  provider  = pihole.main
  domain    = var.domain
  target    = var.target
}

resource "pihole_cname_record" "backup_cname_record" {
  provider  = pihole.backup
  domain    = var.domain
  target    = var.target
}