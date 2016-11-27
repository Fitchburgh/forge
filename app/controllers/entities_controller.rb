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

  def entity_current
    @entity = Entity.find_by(id: params[:id])
    @entity.current = params[:current]
    @entity.save
    render json: @entity.current
  end

  def entity_current_for_game
    temp = Entity.where(user_id: request.env['HTTP_USER_ID']).where(current: true).first
    @entity = { info: temp.info, game_id: temp.game_id, name: temp.name, tags: temp.tags, current: temp.current }
    render json: @entity
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
    @entities = Entity.find_entity_by_input(@entities, params[:name])

    @user = User.find_by(id: 1)
    UserMailer.welcome_email(@user).deliver_now

    render json: @entities
  end

  def by_users
    @entities = Entity.find_entity_by_user(@entities, request.env['HTTP_USER_ID'])
    if @entities.nil?
      render :json => { error: 'no entities found' }, status: 404
    else
      render json: @entities
    end
  end
end
