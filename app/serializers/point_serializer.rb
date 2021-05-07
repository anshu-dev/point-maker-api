class PointSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude, :created_by

  def created_by
    object.user.username
  end

end
