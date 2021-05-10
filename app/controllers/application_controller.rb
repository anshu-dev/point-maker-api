class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :doorkeeper_authorize!
  respond_to :json

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :username]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def jsonapi_parsed_params(raw_params, root_key)
    deserialized_params = ActiveModelSerializers::Deserialization.jsonapi_parse!(raw_params)

    ActionController::Parameters.new(root_key.to_s => deserialized_params)
  end

  private

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
