class ObstaclesController < ApplicationController
  def index
    render :json => Obstacle.all
  end

  def create
    @obstacle = Obstacle.create_obstacle_article(@obstacle, params)
    if @obstacle.save
      render json: @obstacle, status: 201
    else
      render json: @obstacle.errors.full_messages, status: 400
    end
  end

  def update
    if params[:category] == 'obstacle'
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
        render :json => { message: 'obstacle is not found' }, status: 400
      end
    else
      render :json => { message: 'category not found' }, status: 400
    end
  end

  def delete
    if params[:category] == 'obstacle'
      @obstacle = Obstacle.find_by(id: params[:id])
      if @obstacle.nil?
        render :json => { error: 'obstacle not detected' }, status: 404
      else
        render :json => { message: 'obstacle deleted' } if @obstacle.delete
      end
    else
      render :json => { message: 'category not found' }, status: 400
    end
  end
end
