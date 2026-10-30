variable "web_pattern" {
  description = "Machine names that belong to the web group"
  type        = string
  default     = "web-*"
}

variable "timezone" {
  description = "Time zone for schedules and change windows"
  type        = string
  default     = "America/Chicago"
}
