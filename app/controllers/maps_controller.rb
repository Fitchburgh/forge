class MapsController < ApplicationController
  def create
    render json: Map.create_map(@map, params), status: 201
  end

  def index
    @maps = Map.all
    render json: @maps, status: 200
  end

  # not currently working (needs exact match)
  def search
    @maps = Map.find_map_by_input(@maps, params[:name])
    render json: @maps
  end
end
