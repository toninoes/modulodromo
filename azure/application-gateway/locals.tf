locals {
  frontend_ip_configuration_name         = "${var.name}-feip"
  frontend_ip_configuration_private_name = "${var.name}-fepvt-ip"
  public_ip_name                     = "pip-${var.name}"
}