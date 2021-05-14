module LoginHelper
  def token_for_user(user)
    Doorkeeper::AccessToken.create_or_find_by(
      resource_owner_id: user.id,
      expires_in: 7200
    )
  end
end
