class Api::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!

  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: resource
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
