# Gardience Terraform starter

A small, working layout for managing [Gardience](https://gardience.com) setup as code with Terraform or OpenTofu:
node groups, a Salt state, event rules, a runbook with a form, a schedule, a change window, and an enrollment for
new machines. Copy it, change the names, and grow it.

It uses the [gardience/gardience provider](https://registry.terraform.io/providers/gardience/gardience/latest),
which is also on the OpenTofu registry.

## What is in it

| File | What it sets up |
|---|---|
| `groups.tf` | A `web` group by name pattern and a RHEL family group by OS. |
| `states.tf` | `web_base`: nginx installed and running. |
| `rules.tf` | New web machines get `web_base` when they join; nginx restarts itself if it stops; a C: drive warning. |
| `runbooks.tf` | A "Restart a service" form, a weekly schedule for it, and a weekend change window for web machines. |
| `enrollment.tf` | An enrollment whose script joins a new machine to the web group. Use it as cloud-init `user_data`. |

Nothing here runs work on your machines by itself. Saving a state never applies it, and schedules start turned off
until an admin turns each one on in the console.

## Use it

1. In the console, open **Settings > API keys** and create a **configure** key (admins only).
2. Set the environment:

   ```bash
   export GARDIENCE_URL=https://gardience.example.com
   export GARDIENCE_API_KEY=gdn_...
   export GARDIENCE_CA_CERT_FILE=/path/to/gardience.crt   # only for a private or self-signed certificate
   ```

3. Run it:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

   With OpenTofu, use `tofu` in place of `terraform`.

## Already set up by hand?

Gardience can export what you built in the console as Terraform, so you can start from your real setup instead of
this one. See the [provider documentation](https://registry.terraform.io/providers/gardience/gardience/latest/docs).

## In a pipeline

`.github/workflows/terraform.yml` checks formatting and validates on every push. Its `deploy` job plans on pull
requests and applies on `main`, on a self-hosted runner inside your network, once you set the `GARDIENCE_URL`
variable and the `GARDIENCE_API_KEY` secret. Add a remote backend first so state survives between runs.

For running playbooks and runbooks from CI, see the [gdn action](https://github.com/gardience/gdn-action).

## License

MIT. See [LICENSE](LICENSE).
