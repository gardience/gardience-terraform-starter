# New machines built with this enrollment join Gardience on their own and land in the web group.
# Use the script as cloud-init user_data in your aws_instance, azurerm_linux_virtual_machine, or vsphere template:
#   user_data = gardience_enrollment.web.linux_script
resource "gardience_enrollment" "web" {
  label  = "web tier (terraform)"
  hours  = 2160 # 90 days; Terraform opens a new one when it expires
  groups = [gardience_node_group.web.name]
}
