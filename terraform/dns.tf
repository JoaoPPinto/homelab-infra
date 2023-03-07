# firefly DNS
module "firefly_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "firefly.fatska.xyz"
  target  = "proxy.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

module "fidi_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "fidi.fatska.xyz"
  target  = "proxy.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

# Apps DNS
module "apps_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "apps.fatska.xyz"
  target  = "proxy.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

# Raspberrys
module "ocelot_dns" {
  source  = "./modules/homelab_dns_record"
  domain  = "ocelot.fatska.xyz"
  ip      = "192.168.1.12"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

module "zero_dns" {
  source  = "./modules/homelab_dns_record"
  domain  = "zero.fatska.xyz"
  ip      = "192.168.1.13"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

# Proxy DNS
module "proxy_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "proxy.fatska.xyz"
  target  = "ocelot.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

# Services
module "pihole_ocelot_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "pihole.ocelot.fatska.xyz"
  target  = "proxy.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

module "pihole_zero_dns" {
  source  = "./modules/homelab_cname_record"
  domain  = "pihole.zero.fatska.xyz"
  target  = "proxy.fatska.xyz"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}

# PVE Nodes
module "arsenal_dns" {
  source  = "./modules/homelab_dns_record"
  domain  = "arsenal.pve.fatska.xyz"
  ip      = "192.168.1.50"

  providers = {
    pihole.main   = pihole
    pihole.backup = pihole.zero
   }
}
