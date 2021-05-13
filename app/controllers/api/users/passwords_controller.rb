class Api::Users::PasswordsController < Devise::PasswordsController
  skip_before_action :doorkeeper_authorize!
end