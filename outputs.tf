output "web_enrollment_linux_script" {
  description = "cloud-init user_data that enrolls a Linux machine into the web group"
  value       = gardience_enrollment.web.linux_script
  sensitive   = true
}

output "weekly_restart_enabled" {
  description = "Whether an admin has turned the weekly schedule on"
  value       = gardience_schedule.weekly_restart.enabled
}
