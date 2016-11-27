class GameUpdateSetWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false
  def perform(old_name, game)
    Redis.current.del(old_name) if make_new_key == true
    Redis.current.set(game.name, game.attributes.to_json)
    Redis.current.expire(game.name, 2592000)
  end
end
