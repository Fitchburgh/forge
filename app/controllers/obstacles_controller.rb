class ObstaclesController < ApplicationController
  def index
    @obstacles = ActiveRecord::Base.connection.execute("SELECT id, user_id, game_id, published, name, tags, thumbnail FROM obstacles;")
    render :json => @obstacles
  end

  def create
    @obstacle = Obstacle.create_obstacle_article(@obstacle, params, request.env['HTTP_USER_ID'])
    if @obstacle.save
      render json: @obstacle, status: 201
    else
      render :json => { errors: @obstacle.errors.full_messages }, status: 400
    end
  end

  def update
    @obstacle = Obstacle.find_by(id: params[:id])
    if !@obstacle.nil?
      Obstacle.update_obstacle(@obstacle, params, request.env['HTTP_USER_ID'])
      if @obstacle.save
        render :json => @obstacle
      else
        render :json => { errors: @obstacle.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'obstacle is not found' }, status: 400
    end
  end

  def delete
    @obstacle = Obstacle.find_by(id: params[:id])
    if @obstacle.nil?
      render :json => { error: 'obstacle not detected' }, status: 404
    else
      render :json => { message: 'obstacle deleted' } if @obstacle.delete
    end
  end

  def search
    # @obstacles = Obstacle.find_obstacle_by_input(@obstacles, params[:name])
    @obstacles = ActiveRecord::Base.connection.execute("SELECT id, user_id, game_id, published, name, tags, thumbnail FROM obstacles WHERE name LIKE '%#{params[:name]}%';")
    render json: @obstacles
  end

  def select_obstacle
    @obstacle = Obstacle.find_by(id: params[:id])
    if @obstacle.nil?
      render json: @obstacle.errors.full_messages
    else
      render json: @obstacle.info
    end
  end
end
