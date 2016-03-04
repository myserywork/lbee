ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "lbee.com",
    #:user_name => "lbee@lucasluz.com",
    #:password => "bee432@AA",
    :user_name => "no-reply@lbee.com.br",
    :password => "3kgju6dlmo",
    :authentication => "plain",
    :enable_starttls_auto => true
}