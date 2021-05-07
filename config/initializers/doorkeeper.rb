Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record
  use_refresh_token
  api_only
  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    warden.authenticate!(scope: :user)
  end

  grant_flows %w[password]

  resource_owner_from_credentials do
    User.find_by(email: params[:email])
       &.authenticate(params[:password]) || nil
  end
end
