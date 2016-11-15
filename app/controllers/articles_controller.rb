#
class ArticlesController < ApplicationController
  def create
    if params[:category] == 'background'
      create_article(@background, Background)
    elsif params[:category] == 'obstacle'
      create_article(@obstacle, Obstacle)
    elsif params[:category] == 'entity'
      create_article(@entity, Entity)
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
