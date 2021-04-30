require 'rails_helper'

RSpec.describe "Points", type: :request do
  describe "Points API" do

    before do
      3.times {|i| create(:point, name: "new point #{i}") }
    end

    it "returns success status" do
      get '/points'

      expect(response).to have_http_status(:success)
    end

    it "returns all points" do
      get '/points'
      expect(JSON.parse(response.body)['data'].size).to eq 3
    end

    it "returns name, latitude and longitude" do
      get '/points'
      data = JSON.parse(response.body)['data'].first['attributes']
      expect(data.keys).to include 'name'
      expect(data.keys).to include 'latitude'
      expect(data.keys).to include 'longitude'
    end
  end

  describe "Add Point API" do
    it "returns success" do
      post '/points', params: { data: { type: 'points', attributes: { name: 'test', longitude: '34.22222', latitude: '67.99999' }} }

      expect(response).to have_http_status(:success)
    end

    it "create point record based on params" do
      post '/points', params: { data: { type: 'points', attributes: { name: 'test', longitude: '36.22222', latitude: '77.99999' }} }

      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq 'test'
      expect(JSON.parse(response.body)["data"]["attributes"]["longitude"]).to eq '36.22222'
      expect(JSON.parse(response.body)["data"]["attributes"]["latitude"]).to eq '77.99999'
    end
  end

  describe "Update Point API" do
    before do
      create(:point, name: 'update point')
    end

    it "returns success" do
      put "/points/#{Point.first.id}", params: { data: { type: 'points', attributes: { name: 'test', longitude: '34.22222', latitude: '67.99999' }} }

      expect(response).to have_http_status(:success)
    end

    it "update record based on params" do
      put "/points/#{Point.first.id}", params: { data: { type: 'points', attributes: { name: 'updated points', longitude: '34.22222', latitude: '67.99999' }} }
      
      expect(JSON.parse(response.body)["data"]["attributes"]["name"]).to eq 'updated points'
    end
  end

  describe "Delete API" do
    before do
      create(:point)
    end

    it "return success" do
      delete "/points/#{Point.first.id}"
      expect(response).to have_http_status(:success)
    end

    it "delete given record" do
      expect(Point.all.size).to eq 1
      delete "/points/#{Point.first.id}"
      expect(Point.all.size).to eq 0
    end

  end

end
