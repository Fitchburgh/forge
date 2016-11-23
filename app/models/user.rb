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
      @user = User.find_by(id: g.user_id)
      users << @user.username
    end
    users
  end

  def self.find_username_for_collaborators(collaborators)
    result = []
    collaborators.each do |t|
      username = User.find(t.user_id).username
      result.push({
        id: t.id,
        game_id: t.game_id,
        username: username,
        requested: true,
        accepted: true
        })
    end
    result
  end

  def self.find_username_for_requesters(requesters)
    result = []
    requesters.each do |t|
      username = User.find(t.user_id).username
      result.push({
        id: t.id,
        game_id: t.game_id,
        username: username,
        requested: true,
        accepted: false
        })
    end
    result
  end
end
