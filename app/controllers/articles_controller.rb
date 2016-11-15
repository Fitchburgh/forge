require 'pry'
#
class ArticlesController < ApplicationController
  def create
    if params[:category] == 'background'
      @background = Background.create_background_article(@background, params)
      render json: @background
    elsif params[:category] == 'obstacle'
      @obstacle = Obstacle.create_obstacle_article(@obstacle, params)
      render json: @obstacle
    elsif params[:category] == 'entity'
      @entity = Entity.create_entity_article(@entity, params)
      render json: @entity
    else
      halt(404)
    end
  end

  def update
  end

  def delete
  end

  def search
    @backgrounds = Background.find_background_by_input(@backgrounds, params[:tags])
    @obstacles = Obstacle.find_obstacle_by_input(@obstacles, params[:tags])
    @entities = Entity.find_entity_by_input(@entities, params[:tags])

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render :json => @articles
  end

end
