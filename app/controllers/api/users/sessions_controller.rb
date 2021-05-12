class  Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :doorkeeper_authorize!

  def create
    @user = User.find_for_database_authentication(email: params[:username])
    if @user && @user.valid_password?(params[:password])
      render json: @user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
