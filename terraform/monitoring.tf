resource "google_monitoring_uptime_check_config" "api_uptime_check" {
  display_name = "API Uptime Check"
  timeout      = "10s"
  period       = "60s"

  http_check {
    path    = "/healthz"
    port    = 80
    use_ssl = false
  }

  monitored_resource {
    type = "gce_instance"
    labels = {
      project_id  = var.project_id
      instance_id = "your-instance-id"  # Replace with your actual instance ID
      zone        = var.zone            # Replace with the zone of your instance
    }
  }

  selected_regions = ["usa"]

  notification_channels = [google_monitoring_notification_channel.email_notification.id]
}

resource "google_monitoring_notification_channel" "email_notification" {
  display_name = "Email Notification"
  type         = "email"

  labels = {
    email_address = "your-email@example.com"
  }
}