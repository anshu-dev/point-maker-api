require 'google/cloud/firestore'

class Firestore
  def initialize
    @firestore = ::Google::Cloud::Firestore.new(
      project_id: ENV['FIREBASE_PROJECT']
    )
  end

  def create_or_update(table_name, params, doc_id)
    record = @firestore.col(table_name).doc(doc_id)
    record.set(params)
  end
end
