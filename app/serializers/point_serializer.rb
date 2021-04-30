class PointSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude
end
