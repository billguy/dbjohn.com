ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => APP_CONFIG[:smtp_server],
    :domain => APP_CONFIG[:smtp_domain],
    :port => APP_CONFIG[:smtp_port],
    :user_name => APP_CONFIG[:smtp_user],
    :password => APP_CONFIG[:smtp_pass]
}