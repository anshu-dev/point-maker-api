class  Api::Users::SessionsController < Devise::SessionsController
  before_action :set_user, on: :create

  def create
    if @user && @user.valid_password?(sign_in_params[:password])
      @current_user = @user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find_by_email(sign_in_params[:email])
  end
end
