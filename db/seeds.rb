User.create(
  username: 'fitchburgh',
  email: 'taco@pies.com',
  password: 'brandon'
)

Game.create(
  name: 'Quest',
  user_id: 1,
  description: 'test descript'
)

Collaborator.create(
  game_id: 1,
  user_id: 1
)

Map.create(
  game_id: 1,
  name: 'Mappy',
  description: 'map for quest game'
)

Scene.create(
  map_id: 1,
  name: 'Sceney',
  description: 'scene!'
)

Shard.create(
  scene_id: 1,
  category: 'Background',
  name: 'Sky',
  description: 'The sky'
)

Shard.create(
  scene_id: 1,
  category: 'Obstacle',
  name: 'tree',
  description: 'The tree'
)

Shard.create(
  scene_id: 1,
  category: 'Entity',
  name: 'Old Hag',
  description: 'The villian'
)

Background.create(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  shard_id: 1,
  public: true,
  tags: "['blue', 'sky']"
)

Obstacle.create(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  shard_id: 2,
  public: true,
  tags: '[1, 2, 3, 4]'
)

Entity.create(
  obj: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  shard_id: 3,
  public: false,
  tags: "['guns', 'roses']"
)
