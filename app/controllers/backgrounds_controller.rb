class BackgroundsController < ApplicationController
  def index
    @backgrounds = ActiveRecord::Base.connection.execute("SELECT id, user_id, game_id, published, name, tags, thumbnail FROM backgrounds;")
    render :json => @backgrounds
  end

  def create
    @background = Background.create_background_article(@background, params, request.env['HTTP_USER_ID'])
    if @background.save
      render json: @background, status: 201
    else
      render :json => { errors: @background.errors.full_messages }, status: 400
    end
  end

  def update
    @background = Background.find(params[:id])
    if !@background.nil?
      Background.update_background(@background, params, request.env['HTTP_USER_ID'])
      if @background.save
        render json: @background
      else
        render :json => { errors: @background.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'background is not found' }, status: 400
    end
  end

  # for admins to delete profane/NSFW backgrounds
  def delete
    @background = Background.find(params[:id])
    if @background.nil?
      render :json => { error: 'background not detected' }, status: 404
    else
      render :json => { message: 'background deleted' } if @background.delete
    end
  end

  def search
    @backgrounds = ActiveRecord::Base.connection.execute("SELECT id, user_id, game_id, published, name, tags, thumbnail FROM backgrounds WHERE name LIKE '%#{params[:name]}%';")
    render json: @backgrounds
  end

  def select_background
    @background = Background.find(params[:id])
    if @background.nil?
      render json: @background.errors.full_messages
    else
      render json: @background.info
    end
  end
end
