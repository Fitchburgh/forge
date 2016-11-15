#
class ArticlesController < ApplicationController
  def create
    if params[:category] == 'background'
      @background = Background.new(asset_params)
      if @background.save
        render json: @background
      else
        render json: { errors: @background.errors.full_messages }
      end
    elsif params[:category] == 'obstacle'
      @obstacle = Obstacle.new(asset_params)
      if @obstacle.save
        render json: @obstacle
      else
        render json: { errors: @obstacle.errors.full_messages }
      end
    elsif params[:category] == 'entity'
      @entity = Entity.new(asset_params)
      if @entity.save
        render json: @entity
      else
        render json: { errors: @entity.errors.full_messages }
      end
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

  private

  def asset_params
    # only permitting user and scene ID's here for testing.  these will come from front end
    params.permit(:name, :obj, :description, :user_id, :scene_id, :tags, :public)
  end
end
