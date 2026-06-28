app_name = "CosmOS_core"
app_title = "CosmOS"
app_publisher = "Protect PLast LLC Middle East"
app_description = "CosmOS For Protect PLast LLC Middle East"
app_email = "saleelhussain@gmail.com"
app_license = "gpl-2.0"

# Branding
app_logo_url = "/assets/CosmOS_core/images/CosmOS-logo.png"
app_icon = "/assets/CosmOS_core/images/CosmOS-icon.png"
app_splash = "/assets/CosmOS_core/images/CosmOS-logo.png"
app_email_splash = "/assets/CosmOS_core/images/CosmOS-email-logo.png"

# Replace Frappe brand everywhere
app_include_css = "/assets/CosmOS_core/css/CosmOS.css"

# Scheduled tasks
scheduler_events = {
    "cron": {
        "0 6 * * *": [
            "cosmos_core.visa_alerts.send_visa_expiry_alerts"
        ]
    },
}
