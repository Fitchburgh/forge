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
    @backgrounds = []
    backgrounds = Background.all
    backgrounds.each do |t|
      @backgrounds << t.name if t.tags.include?(params[:tags]) || t.name.include?(params[:tags])
    end

    @obstacles = []
    obstacles = Obstacle.all
    obstacles.each do |t|
      @obstacles << t.name if t.tags.include?(params[:tags]) || t.name.include?(params[:tags])
    end

    @entities = []
    entities = Entity.all
    entities.each do |t|
      @entities << t.name if t.tags.include?(params[:tags]) || t.name.include?(params[:tags])
    end

    @articles = { 'backgrounds' => @backgrounds, 'obstacles' => @obstacles, 'entities' => @entities }
    render :json => @articles
  end

end
