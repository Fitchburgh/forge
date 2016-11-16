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
    if params[:category] == 'background'
      @background = Background.find_by(id: params[:id])
      if !@background.nil?

        @background.name = params[:name].downcase
        @background.tags = params[:tags].downcase
        @background.user_id = params[:user_id]
        @background.game_id = params[:game_id]
        @background.obj = params[:obj]

        if @background.save
          render :json => @background
        else
          render :json => { :errors => @background.errors.full_messages }, status: 404
        end
      else
        render :json => { message: 'background is not found' }
      end
    elsif params[:category] == 'obstacle'
      @obstacle = Obstacle.find_by(id: params[:id])
      if !@obstacle.nil?

        @obstacle.name = params[:name].downcase
        @obstacle.tags = params[:tags].downcase
        @obstacle.user_id = params[:user_id]
        @obstacle.game_id = params[:game_id]
        @obstacle.obj = params[:obj]

        if @obstacle.save
          render :json => @obstacle
        else
          render :json => { :errors => @obstacle.errors.full_messages }, status: 404
        end
      else
        render :json => { message: 'obstacle is not found' }
      end
    elsif params[:category] == 'entity'
      @entity = Entity.find_by(id: params[:id])
      if !@entity.nil?

        @entity.name = params[:name].downcase
        @entity.tags = params[:tags].downcase
        @entity.user_id = params[:user_id]
        @entity.game_id = params[:game_id]
        @entity.obj = params[:obj]

        if @entity.save
          render :json => @entity
        else
          render :json => { :errors => @entity.errors.full_messages }, status: 404
        end
      else
        render :json => { message: 'entity is not found' }
      end
    else
      render :json => { message: 'category not found' }
    end
  end

  def delete
    if params[:category] == 'background'
      @background = Background.find_by(id: params[:id])
      if @background.nil?
        render :json => { error: 'background not detected' }, status: 404
      else
        render :json => { message: 'background deleted' } if @background.delete
      end
    elsif params[:category] == 'obstacle'
      @obstacle = Obstacle.find_by(id: params[:id])
      if @obstacle.nil?
        render :json => { error: 'obstacle not detected' }, status: 404
      else
        render :json => { message: 'obstacle deleted' } if @obstacle.delete
      end
    elsif params[:category] == 'entity'
      @entity = Entity.find_by(id: params[:id])
      if @entity.nil?
        render :json => { error: 'entity not detected' }, status: 404
      else
        render :json => { message: 'entity deleted' } if @entity.delete
      end
    else
      halt(404)
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
