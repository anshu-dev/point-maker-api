class ApplicationMailer < ActionMailer::Base
  default from: "Point Maket <#{ENV['SMTP_USERNAME']}>"
  layout 'mailer'
end
