# A saved Salt state. Gardience checks it before publishing. Saving never applies it:
# people apply it from the console, or the join rule below applies it to each new web machine.
resource "gardience_state" "web_base" {
  name    = "web_base"
  content = <<-YAML
    nginx:
      pkg.installed: []
      service.running:
        - enable: True
        - require:
          - pkg: nginx
  YAML
}
