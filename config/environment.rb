# Load the rails application
require File.expand_path('../application', __FILE__)

MindFinder::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "",
    password: ""
  }
end

# Initialize the rails application
MindFinder::Application.initialize!