require 'rails_helper'

RSpec.describe "Points", type: :request do
  let(:user) { create(:user) }
  let(:token) { token_for_user(user).token }
  let(:auth_header) { { Authorization: "Bearer #{token}" } }

  context "Points API" do
    before do
      geometry={ longitude: -92.404940541294, latitude: 34.74333714650257 }
      3.times {|i| create(:point, name: "new point #{i}", geometry: geometry, user: user) }
    end

    it "returns success status" do
      get '/api/points',  headers: auth_header
      expect(response).to have_http_status(:success)
    end

    it "returns all points" do
      get '/api/points',  headers: auth_header

      expect(JSON.parse(response.body)['data'].size).to eq 3
    end

    it "returns name, latitude and longitude" do
      get '/api/points',  headers: auth_header
      data = JSON.parse(response.body)['data'].first['attributes']
      expect(data.keys).to include 'name'
      expect(data.keys).to include 'latitude'
      expect(data.keys).to include 'longitude'
    end
  end

  context "Add Point API" do
    it "returns success" do
      post '/api/points',  headers: auth_header, params: { data: { type: 'points', attributes: { name: 'test', geometry: { longitude: '34.22222', latitude: '67.99999' } }} }

      expect(response).to have_http_status(:success)
    end

    it "create point record based on params" do
      post '/api/points',  headers: auth_header, params: { data: { type: 'points', attributes: { name: 'test', geometry: { longitude: '36.22222', latitude: '77.99999' }} } }

      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq 'test'
      expect(JSON.parse(response.body)["data"]["attributes"]["longitude"]).to eq 36.22222
      expect(JSON.parse(response.body)["data"]["attributes"]["latitude"]).to eq 77.99999
    end
  end

  context "Update Point API" do
    before do
      create(:point, name: 'update point', geometry: {"type"=>"Point", "coordinates"=>[-92.404940541294, 34.74333714650257]})
    end

    it "returns success" do
      put "/api/points/#{Point.first.id}",  headers: auth_header, params: { data: { type: 'points', attributes: { name: 'test', geometry: { longitude: '34.22222', latitude: '67.99999' } }} }

      expect(response).to have_http_status(:success)
    end

    it "update record based on params" do
      put "/api/points/#{Point.first.id}",  headers: auth_header, params: { data: { type: 'points', attributes: { name: 'updated points', geometry: { longitude: '34.22222', latitude: '67.99999' } }} }

      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq 'updated points'
    end
  end

  context "Delete API" do
    before do
      create(:point, geometry: {"type"=>"Point", "coordinates"=>[-92.404940541294, 34.74333714650257]})
    end

    it "return success" do
      delete "/api/points/#{Point.first.id}",  headers: auth_header
      expect(response).to have_http_status(:success)
    end

    it "delete given record" do
      expect(Point.all.size).to eq 1
      delete "/api/points/#{Point.first.id}",  headers: auth_header
      expect(Point.all.size).to eq 0
    end

  end

end
