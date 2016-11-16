class BackgroundsController < ApplicationController
  def index
    render :json => Background.all
  end

  def create
    @background = Background.create_background_article(@background, params)
    if @background.save
      render json: @background, status: 201
    else
      render json: @background.errors.full_messages, status: 400
    end
  end

  def update
    @background = Background.find_by(id: params[:id])
    if !@background.nil?
      Background.update_background(@background, params)
      if @background.save
        render json: @background
      else
        render :json => { errors: @background.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'background is not found' }, status: 400
    end
  end

  def delete
    @background = Background.find_by(id: params[:id])
    if @background.nil?
      render :json => { error: 'background not detected' }, status: 404
    else
      render :json => { message: 'background deleted' } if @background.delete
    end
  end
end
