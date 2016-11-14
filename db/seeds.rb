User.create(
  username: 'fitchburgh'
)

Game.create(
  name: 'Quest',
  tags: '[war, fight, adventure]',
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

Background.create(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  scene_id: 1,
  public: true,
  name: 'Sky',
  tags: "['blue', 'sky']"
)

Obstacle.create(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  scene_id: 1,
  public: true,
  name: 'tree',
  tags: '[1, 2, 3, 4]'
)

Entity.create(
  obj: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  scene_id: 1,
  public: false,
  name: 'Old Hag',
  tags: "['guns', 'roses']"
)
