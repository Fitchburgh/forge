class EntitiesController < ApplicationController
  def index
    render :json => Entity.all
  end

  def create
    @entity = Entity.create_entity_article(@entity, params)
    if @entity.save
      render json: @entity, status: 201
    else
      render json: @entity.errors.full_messages, status: 400
    end
  end

  def update
    @entity = Entity.find_by(id: params[:id])
    if !@entity.nil?
      @entity.update_entity(@entity, params)
      if @entity.save
        render :json => @entity
      else
        render :json => { :errors => @entity.errors.full_messages }, status: 404
      end
    else
      render :json => { message: 'entity is not found' }, status: 400
    end
  end

  def delete
    @entity = Entity.find_by(id: params[:id])
    if @entity.nil?
      render :json => { error: 'entity not detected' }, status: 404
    else
      render :json => { message: 'entity deleted' } if @entity.delete
    end
  end
end
