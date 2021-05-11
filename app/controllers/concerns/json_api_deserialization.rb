require 'active_support/concern'

module JsonApiDeserialization
  extend ActiveSupport::Concern

  protected

  def jsonapi_parsed_params(raw_params, root_key)
    deserialized_params = ActiveModelSerializers::Deserialization.jsonapi_parse!(raw_params)

    ActionController::Parameters.new(root_key.to_s => deserialized_params)
  end
end
