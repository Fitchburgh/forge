class CharactersController < ApplicationController
  def search
  end

  def create
    @character = Character.new(name: params[:name], user_id: params[:user_id], current: params[:current], obj: params[:obj])
  end

  def delete
  end

  def update
  end
end
