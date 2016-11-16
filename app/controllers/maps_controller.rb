class MapsController < ApplicationController
  def create
    render json: Map.create_map(@map, params), status: 201
  end

  def index
    @maps = Map.all
    render json: @maps, status: 200
  end

  def search
    @map = Map.find_by(name: params[:name])
    if @map.nil?
      render json: 'Map does not exist', status: 404
    else
      render json: @map
    end
  end
end
