class CharactersController < ApplicationController
  def index
    @characters = Character.where(user_id: params[:user_id])
    render json: @characters
  end

  def current_character
    @current_character = Character.where(user_id: params[:user_id], current: true)
    render json: @current_character
  end

  def create
    @character = Character.create_character(params)
    if @character.save
      render json: @character
    else
      render :json => { errors: @character.errors.full_messages }, status: 400
    end
  end

  def delete
    @character = Character.find_by(id: params[:id])
    if !@character.nil?
      if @character.user_id == params[:user_id].to_i
        render :json => { message: 'character deleted' } if @character.delete
      else
        render :json => { error: 'only the creator can delete this character' }, status: 400
      end
    else
      render :json => { error: 'character not detected' }, status: 404
    end
  end

  def update
    @character = Character.find_by(id: params[:id])
    if !@character.nil?
      if @character.user_id == params[:user_id].to_i
        Character.update_character(@character, params)
        if @character.save
          render json: @character
        else
          render :json => { errors: @character.errors.full_messages }, status: 404
        end
      else
        render :json => { message: 'only the creator can edit this character' }, status: 400
      end
    else
      render :json => { error: 'character not detected' }, status: 404
    end
  end
end
