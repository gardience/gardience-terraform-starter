# Node groups: who a rule, runbook, or change window applies to.
resource "gardience_node_group" "web" {
  name    = "web"
  kind    = "match"
  pattern = var.web_pattern
}

resource "gardience_node_group" "rhel" {
  name = "rhel-family"
  kind = "os"
  os   = "RHEL family"
}
