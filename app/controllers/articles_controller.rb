require 'pry'
#
class ArticlesController < ApplicationController
  def index
    @backgrounds = Background.all
    @obstacles = Obstacle.all
    @entities = Entity.all

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render :json => @articles
  end

  def index_backgrounds
    @backgrounds = Background.all
    render :json => @backgrounds
  end

  def index_obstacles
    @obstacles = Obstacle.all
    render :json => @obstacles
  end

  def index_entities
    @entities = Entity.all
    render :json => @entities
  end

  def create
    if params[:category] == 'background'
      render json: Background.create_background_article(@background, params), status: 201

    elsif params[:category] == 'obstacle'
      render json: Obstacle.create_obstacle_article(@obstacle, params), status: 201

    elsif params[:category] == 'entity'
      render json: Entity.create_entity_article(@entity, params), status: 201

    else
      halt(404)
    end
  end

  def update

  end

  def delete
    @background = Background.find_by(id: params[:id])
    if @background.nil?
      render :json => { error: 'background not detected' }, status: 404
    else
      render :json => { message: 'background deleted' } if @background.delete
    end
  end

  def search
    @backgrounds = Background.find_background_by_input(@backgrounds, params[:tags])
    @obstacles = Obstacle.find_obstacle_by_input(@obstacles, params[:tags])
    @entities = Entity.find_entity_by_input(@entities, params[:tags])

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render :json => @articles
  end

end
