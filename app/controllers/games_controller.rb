class GamesController < ApplicationController
  def create
    @game = Game.new(
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      description: params[:description].downcase,
      info: params[:info],
      user_id: request.env['HTTP_USER_ID'],
      published: params[:published]
    )
    if @game.save
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render :json => { game: [@game.id, @game.name, @game.tags, @game.description, @game.user_id] }
    else
      render :json => { :errors => @game.errors.full_messages }, status: 400
    end
  end

  def update
    make_new_key = false
    @game = Game.find_by(id: params[:id])

    if !(@game.name == params[:name])
      make_new_key = true
      old_name = @game.name
    end

    @game.name = params[:name].downcase
    @game.tags = params[:tags].to_s.downcase
    @game.description = params[:description].downcase
    @game.info = params[:info]
    @game.published = params[:published]
    if @game.save
      Redis.current.del(old_name) if make_new_key = true
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render :json => { game: [@game.id, @game.name, @game.tags, @game.description, @game.user_id, @game.published] }
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 404
    end
  end

  def delete
    @game = Game.find_by(id: params[:id])
    if !@game.nil?
      if @game.user_id == request.env['HTTP_USER_ID']
        @entities = Entity.where(game_id: @game.id)
        @entities.each do |e|
          e.game_id = 0
          e.save
        end

        @obstacles = Obstacle.where(game_id: @game.id)
        @obstacles.each do |o|
          o.game_id = 0
          o.save
        end

        @backgrounds = Background.where(game_id: @game.id)
        @backgrounds.each do |b|
          b.game_id = 0
          b.save
        end

        Collaborator.delete(Collaborator.where(game_id: @game.id))

        Scene.delete(Scene.where(game_id: @game.id))

        Map.delete(Map.where(game_id: @game.id))

        if @game.delete
          Redis.current.del(@game.name)
          render :json => { message: 'game deleted' }, status: 200
        end
      else
        render :json => { error: 'only the creator can delete this game' }, status: 400
      end
    else
      render :json => { error: 'game not detected' }, status: 404
    end
  end

  def search
    @games = Game.find_game_by_input(@games, params[:name])
    render json: @games
  end

  def find_user_games
    user_games = Game.where(user_id: request.env['HTTP_USER_ID'])
    if user_games.empty?
      render json: []
    else
      render json: user_games
    end
  end

  def savegame
    @savegame = SaveGame.new(
      game_id: params[:game_id],
      user_id: request.env['HTTP_USER_ID'],
      info: params[:info]
    )
    if @savegame.save
      render json: @savegame
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 400
    end
  end

  def welcome
  end
end
