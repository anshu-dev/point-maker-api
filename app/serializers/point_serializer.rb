class PointSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude, :created_by

  def created_by
    object.user.username
  end

  def latitude
    object.coordinates.last
  end

  def longitude
    object.coordinates.first
  end
end
