class UserMailer < Devise::Mailer
  default from: "Point Maket <#{ENV['SMTP_USERNAME']}>"

  def reset_password_instructions(record, token, opts={})
    super
  end
end