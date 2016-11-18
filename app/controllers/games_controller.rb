class GamesController < ApplicationController
  def create
    @game = Game.new(
      name: params[:name].downcase,
      tags: params[:tags].to_s.downcase,
      description: params[:description].downcase,
      obj: params[:obj],
      user_id: request.env['HTTP_USER_ID']
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
    @game.tags = params[:tags].downcase
    @game.description = params[:description].downcase
    @game.obj = params[:obj]
    if @game.save
      Redis.current.del(old_name) if make_new_key = true
      Redis.current.set(@game.name, @game.attributes.to_json)
      Redis.current.expire(@game.name, 2592000)
      render :json => { game: [@game.id, @game.name, @game.tags, @game.description, @game.user_id] }
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
    @games = []
    games = Game.all
    games.each do |t|
      if t.tags.include?(params[:tags].downcase) || t.name.include?(params[:tags].downcase)
        @games << {id: t.id, name: t.name, tags: t.tags, user_id: t.user_id, description: t.description, created_at: t.created_at}
      end
    end
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
    # need to automatically populate user_id and game_id fields
    @savegame = SaveGame.new(
      game_id: params[:game_id],
      user_id: request.env['HTTP_USER_ID'],
      obj: params[:obj]
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
