# A form people fill in to restart one service on a node group.
resource "gardience_runbook" "restart" {
  id          = "restart-service"
  name        = "Restart a service"
  description = "Restarts one service on every machine in a node group"
  fun         = "service.restart"
  args        = ["{{service}}"]
  target      = "{{group}}"
  target_type = "nodegroup"
  survey = [
    { name = "service", label = "Service", default = "nginx" },
    { name = "group", label = "Node group", type = "nodegroup", default = gardience_node_group.web.name },
  ]
}

# Runs it every Sunday at 03:00. Schedules start turned off: an admin turns each one on
# in the console (Automation > Schedules), so Terraform alone never starts work on your machines.
resource "gardience_schedule" "weekly_restart" {
  id     = "weekly-nginx-restart"
  name   = "Weekly nginx restart"
  ref    = gardience_runbook.restart.id
  inputs = { service = "nginx", group = gardience_node_group.web.name }
  days   = ["sun"]
  time   = "03:00"
  tz     = var.timezone
}

# Changes to web machines wait for the weekend evening window.
resource "gardience_change_window" "web_weekend" {
  id        = "web-weekend"
  nodegroup = gardience_node_group.web.name
  days      = ["sat", "sun"]
  start     = "22:00"
  end       = "23:59"
  tz        = var.timezone
}
