class  Api::Users::SessionsController < Devise::SessionsController
  before_action :set_user, on: :create

  def create
    if @user && @user.valid_password?(user_params[:password])
      @current_user = @user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params.permit(
      :email,
      :password
    )
  end

  def set_user
    @user = User.find_by_email(user_params[:email])
  end
end
