class User < ApplicationRecord
  validates :username, :token, :uid, presence: true, uniqueness: true

  def self.create_new_user(var, params)
    var = self.new_user(params)
  end

  def self.new_user(params)
    User.new(
      username: params[:username].downcase,
      token: params[:token],
      uid: params[:uid],
      google_oauth_data: params[:google_oauth_data]
    )
  end

  def self.find_username_by_game_creator_id(games)
    users = []
    games.each do |g|
      @user = User.find_by(id: g[:user_id])
      users << @user.username
    end
    users
  end

  def self.find_username_for_collaborators(collaborators)
    result = []
    game_id = collaborators.first[0][1]
    game_name = Game.find(game_id).name
    collaborators.first.each do |t|
      username = User.find(t[2]).username
      result.push({
        id: t[0],
        game_id: t[1],
        user_id: t[2],
        game_name: game_name,
        username: username,
        requested: t[3],
        accepted: t[4]
        })
    end
    result
  end

  def self.find_username_for_requesters(requesters)
    result = []
    game_id = requesters.first[0][1]
    game_name = Game.find(game_id).name
    requesters.first.each do |t|
      username = User.find(t[2]).username
      result.push({
        id: t[0],
        game_id: t[1],
        user_id: t[2],
        game_name: game_name,
        username: username,
        requested: t[3],
        accepted: t[4]
        })
    end
    result
  end
end
