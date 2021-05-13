class Api::PointsController < ApplicationController
  after_action :update_to_firestore, only: [:create, :update]

  def index
    @points = current_user.points
    @points = (params[:name] ? search : @points).order('updated_at DESC')

    render json: @points
  end

  def create
    @point = current_user.points.new(point_params)
    if @point.save
      render json: @point
    else
      render json: { errors: 'there is some issue in storing' }, status: :forbidden
    end
  end

  def show
    point = Point.find_by(id: params[:id])
    if point
      render json: point
    else
      render json: { errors: 'No matching record found' }, status: :not_found
    end
  end

  def update
    @point = Point.find(params[:id])

    if @point.update(point_params)
      render json: @point
    else
      render json: { errors: 'there is some issue in update' }, status: :forbidden
    end
  end

  def destroy
    point = Point.find(params[:id])
    if point.destroy
      render json: point
    else
      render json: { errors: 'there is some issue in deletion' }, status: :forbidden
    end
  end

  private

  def search
    @points.where("name ilike ?","%#{params[:name]}%")
  end

  def point_params
    jsonapi_parsed_params(params, :point).require(:point).permit(
      :name,
      geometry: [
        :longitude,
        :latitude
      ]
    )
  end

  def update_to_firestore
    data = {
      name: @point[:name],
      geometry: @point[:geometry]
    }

    Firestore.new.update_to_firestore('points', data, @points.id)
  end
end
