class ObstaclesController < ApplicationController
  def index
    render :json => Obstacle.all
  end

  def create
    @obstacle = Obstacle.create_obstacle_article(@obstacle, params, request.env['HTTP_USER_ID'].to_i)
    if @obstacle.save
      render json: @obstacle, status: 201
    else
      render :json => { errors: @obstacle.errors.full_messages }, status: 400
    end
  end

  def update
    @obstacle = Obstacle.find_by(id: params[:id])
    if !@obstacle.nil?
      Obstacle.update_obstacle(@obstacle, params, request.env['HTTP_USER_ID'].to_i)
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
    @obstacles = []
    obstacles = Obstacle.all
    obstacles.each do |t|
      if t.tags.include?(params[:tags].downcase) || t.name.include?(params[:tags].downcase)
        @obstacles << t
      end
    end
    render json: @obstacles
  end
end
