require 'google/cloud/firestore'

class Firestore
  def initialize
    @firestore = ::Google::Cloud::Firestore.new(
      project_id: ENV['FIREBASE_PROJECT']
    )
  end

  def update_to_firestore(model, params, doc_id)
    record = @firestore.col(model).doc(doc_id)
    record.set(params)
  end
end
