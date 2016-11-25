class Collaborator < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def self.create_new_collaborator(var, params, auth_id)
    var = self.new_collaborator(params, auth_id)
  end

  def self.new_collaborator(params, auth_id)
    Collaborator.new(
      game_id: params[:game_id],
      user_id: auth_id,
      requested: true,
      accepted: false
    )
  end

  def self.make_user_collaborator(var, params, auth_id)
    var = self.user_collaborator(params, auth_id)
  end

  def self.user_collaborator(params, auth_id)
    Collaborator.new(
      game_id: params[:game_id],
      user_id: auth_id,
      requested: true,
      accepted: true
    )
  end

  # this can prob be refactored to using toggle! helper
  def self.flip_requested_value(var)
    if var.requested == false
      var.requested = true
    else
      var.requested = false
    end
    var
  end

  # this can prob be refactored to using toggle! helper
  def self.flip_accepted_value(var)
    if var.accepted == false
      var.accepted = true
    else
      var.accepted = false
    end
    var
  end

  def self.find_requesters_by_game_id(ids)
    requesters = []
    ids.each do |id|
      @requesters = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, false)
      requesters << @requesters
    end
    requesters.uniq
  end

  def self.find_collaborations_by_user(auth_id)
    @collaborations = Collaborator.where('user_id = ? AND requested = ? AND accepted = ?', auth_id, true, true)
    game_ids = []
    @collaborations.each do |t|
      game_ids << t.game_id
    end
    game_ids
  end

  def self.return_user_collaborations(games, users)
    length = users.length
    a = 0
    result = []
    length.times do
      result << { id: games[a][:id], name: games[a][:name], tags: games[a][:tags], username: users[a], description: games[a][:description], published: games[a][:published], score: games[a][:score], created_at: games[a][:created_at] }
      a += 1
    end
    result
  end

  def self.find_collaborators_by_game(var, ids)
    collaborators = []
    ids.each do |id|
      var = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, true)
      collaborators.concat(var)
    end
    collaborators
  end

  def self.find_requesters_by_game(var, ids)
    requesters = []
    ids.each do |id|
      var = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, false)
      requesters.concat(var)
    end
    requesters
  end
end
