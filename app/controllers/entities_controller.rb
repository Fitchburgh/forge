class EntitiesController < ApplicationController
  def index
    render :json => Entity.all
  end

  def create
    @entity = Entity.create_entity_article(@entity, params, request.env['HTTP_USER_ID'])
    if @entity.save
      render json: @entity, status: 201
    else
      render :json => { errors: @entity.errors.full_messages }, status: 400
    end
  end

  def update
    @entity = Entity.find_by(id: params[:id])
    if !@entity.nil?
      Entity.update_entity(@entity, params, request.env['HTTP_USER_ID'])
      if @entity.save
        render :json => @entity
      else
        render :json => { errors: @entity.errors.full_messages }, status: 404
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

  def search
    @entities = []
    entities = Entity.all
    entities.each do |t|
      if t.tags.include?(params[:tags].downcase) || t.name.include?(params[:tags].downcase)
        @entities << t
      end
    end
    render json: @entities
  end
end
