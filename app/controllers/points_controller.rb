class PointsController < ApplicationController

  def index
    points = Point.all
    render json: points
  end

  def create

    point = Point.new(point_params)
    if point.save
      render json: point
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
    point = Point.find(params[:id])
    if point.update(point_params)
      render json: point
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

  def point_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params)
  end
end
