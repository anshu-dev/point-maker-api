require 'rgeo/geo_json'

class Point < ApplicationRecord
  include FirestoreConcern

  before_save :encode_coordinates
  after_save :update_firestore

  belongs_to :user

  def encode_coordinates
    self.geometry = RGeo::GeoJSON.encode(decode_coordinates)
  end

  def decode_coordinates
    geoData = {"type":"Point","coordinates":["#{longitude}", "#{latitude}"]}.as_json
    RGeo::GeoJSON.decode(geoData)
  end

  def longitude
    geometry['longitude']
  end

  def latitude
    geometry['latitude']
  end

  def coordinates
    geometry['coordinates']
  end

  def firestore_data
    {
      name: self[:name],
      geometry: self[:geometry],
      created_by: user.username
    }
  end
end
