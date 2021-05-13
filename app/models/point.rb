require 'rgeo/geo_json'

class Point < ApplicationRecord

  BASE_URL = ENV['BASE_URL']

  before_save :encode_coordinates
  after_save :update_to_firebase
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

  private

    def update_to_firebase
      # client.push("point", self.as_json)
    end

    def client
      @_client ||= Firebase::Client.new(BASE_URL)
    end
end
