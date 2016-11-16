class CharactersController < ApplicationController
  def search
  end

  def create
    @character = Character.new character_params
    if @character.save
      render json: @character, status: 201
    else
      render json: @character.errors.full_messages, status: 400
    end
  end

  def delete
  end

  def update
  end

  private

  def character_params
    params.permit(:name, :user_id, :current, :obj)
  end
end
