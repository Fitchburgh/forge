require 'pry'
#
class ArticlesController < ApplicationController
  def index
    @articles = { 'backgrounds' => Background.all, 'obstacles' => Obstacle.all, 'entities' => Entity.all }
    render :json => @articles
  end

  def index_backgrounds
    render :json => Background.all
  end

  def index_obstacles
    render :json => Obstacle.all
  end

  def index_entities
    render :json => Entity.all
  end

  def create
    if params[:category] == 'background'
      render json: Background.create_background_article(@background, params)
    elsif params[:category] == 'obstacle'
      render json: Obstacle.create_obstacle_article(@obstacle, params)
    elsif params[:category] == 'entity'
      render json: Entity.create_entity_article(@entity, params)
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
