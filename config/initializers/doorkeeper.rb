Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record
  use_refresh_token

  resource_owner_authenticator do
    warden.authenticate(scope: :user)
  end

  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:username], params[:password])
  end

  grant_flows %w(password)
  skip_client_authentication_for_password_grant true
  allow_blank_redirect_uri true

  skip_authorization do
    true
  end
end
