class ArticlesController < ApplicationController
  def search
    @backgrounds = Background.find_background_by_input(@backgrounds, params[:tags])
    @obstacles = Obstacle.find_obstacle_by_input(@obstacles, params[:tags])
    @entities = Entity.find_entity_by_input(@entities, params[:tags])

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render json: @articles
  end

  def find_game_articles
    @game = Game.find_by(id: params[:game_id])
    @backgrounds = Background.find_background_by_game(@backgrounds, params[:game_id])
    @obstacles = Obstacle.find_obstacle_by_game(@obstacles, params[:game_id])
    @entities = Entity.find_entity_by_game(@entities, params[:game_id])
    @events = Event.find_event_by_game(@events, params[:game_id])

    @articles = { 'gameName' => @game.name, 'availableBackgrounds' => @backgrounds, 'availableObstacles' => @obstacles, 'availableEntities' => @entities, 'availableEvents' => @events }
    render json: @articles
  end
end
