class GamePlay < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def self.add_game_play(var, params, auth_id)
    var = self.new_play(params, auth_id)
  end

  def self.new_play(params, auth_id)
    GamePlay.new(
      game_id: params[:game_id],
      user_id: auth_id,
      plays: 1
    )
  end
end
