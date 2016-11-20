require 'pry'
#
class ArticlesController < ApplicationController
  def index
    @articles = { 'backgrounds' => Background.all, 'obstacles' => Obstacle.all, 'entities' => Entity.all }
    render json: @articles
  end

  def search
    @backgrounds = Background.find_background_by_input(@backgrounds, params[:tags])
    @obstacles = Obstacle.find_obstacle_by_input(@obstacles, params[:tags])
    @entities = Entity.find_entity_by_input(@entities, params[:tags])

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render json: @articles
  end

  def find_game_articles
    @backgrounds = Background.find_background_by_game(@backgrounds, params[:game_id])
    @obstacles = Obstacle.find_obstacle_by_game(@obstacles, params[:game_id])
    @entities = Entity.find_entity_by_game(@entities, params[:game_id])

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render json: @articles
  end
end
