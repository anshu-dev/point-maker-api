require 'rgeo/geo_json'

class Point < ApplicationRecord

  BASE_URL = ENV['BASE_URL']

  before_save :encode_coordinates

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
end
