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

  def self.flip_requested_value(var)
    if var.requested == false
      var.requested = true
    else
      var.requested = false
    end
    var
  end

  def self.flip_accepted_value(var)
    if var.accepted == false
      var.accepted = true
    else
      var.accepted = false
    end
    var
  end
end
