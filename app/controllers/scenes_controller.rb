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
    @scene = Scene.find_by(name: params[:name])
    if @scene.nil
      render json: 'Scene does not exist', status: 404
    else
      render json: @scene
    end
  end
end
