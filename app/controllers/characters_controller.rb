class CharactersController < ApplicationController
  def index
    @characters = Character.where(user_id: params[:user_id])
    render :json => @characters
  end

  def current_character

  end

  def create
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
  end
end
