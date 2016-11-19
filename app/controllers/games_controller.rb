class GamesController < ApplicationController
  def create
    @game = Game.create_new_game(@game, params, request.env['HTTP_USER_ID'])
    if @game.save
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render :json => { id: @game.id, name: @game.name, tags: @game.tags, description: @game.description, user_id: @game.user_id }
    else
      render :json => { :errors => @game.errors.full_messages }, status: 400
    end
  end

  def update
    @game = Game.find_by(id: params[:id])

    # I'd like to make this a model method, but we need to return two things:
    # true or false, and if true the name of the game before we update it
    make_new_key = false
    if !(@game.name == params[:name])
      make_new_key = true
      old_name = @game.name
    end

    Game.update_game(@game, params)
    if @game.save
      Redis.current.del(old_name) if make_new_key = true
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render :json => { id: @game.id, name: @game.name, tags: @game.tags, description: @game.description, user_id: @game.user_id, published: @game.published }
    else
      render :json => { :errors => @savegame.errors.full_messages }, status: 404
    end
  end

  def delete
    @game = Game.find_by(id: params[:id])
    if !@game.nil?
      if @game.user_id == request.env['HTTP_USER_ID'].to_i
        @game.archived = true
        @game.archived_at = Time.now.strftime '%Y-%m-%d %H:%M:%S'
        @game.save!
        render :json => { message: 'game archived' }, status: 200
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
