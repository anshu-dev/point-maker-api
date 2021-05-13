class Api::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!
  after_action :update_to_firestore, only: [:create]

  def create
    build_resource(user_params)

    resource.save
    if resource.persisted?
      render json: resource
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    jsonapi_parsed_params(params, :user).require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation
    )
  end

  def update_to_firestore
    data = {
      email: resource[:email],
      username: resource[:username]
    }

    Firestore.new.update_to_firestore('users', data, resource.id)
  end
end
