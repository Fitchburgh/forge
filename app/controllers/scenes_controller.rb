require 'pry'
#
class ScenesController < ApplicationController
  def create
    render json: Scene.create_scene(@scene, params), status: 201
  end

  def index
    @scenes = Scene.all
    render json: @scenes, status: 200
  end

  def search
    @scenes = Scene.find_scene_by_input(@scenes, params[:name])
    render json: @scenes
  end
end
