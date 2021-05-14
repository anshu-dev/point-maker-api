require 'active_support/concern'

module FirestoreConcern
  extend ActiveSupport::Concern

  protected

  def update_firestore
    Firestore.new.create_or_update(table_name, firestore_data, id)
  end

  def table_name
    self.class.name.underscore.pluralize
  end
end
