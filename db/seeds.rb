User.create(
  username: 'fitchburgh',
  token: 'asoidaiosdjgas8235hy09130t1h3tQahg8123450176304',
  uid: "12498720913851029",
  google_oauth_data: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Game.create(
  id: 0,
  name: 'Orphans',
  tags: '[]',
  user_id: 1,
  description: 'Where all the orphan articles live',
  obj: "{something: here}"
)

Game.create(
  name: 'quest',
  tags: '[war, fight, adventure]',
  user_id: 1,
  description: 'test descript',
  obj: "{'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}}
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}}
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}},
    'some': 'text', 'goes': 'here'
      {'sometimes': 'its', 'really'
        {'complicated'
          {[1, 2, 3, 4, 5]}}}
  }"
)

Collaborator.create(
  game_id: 1,
  user_id: 1
)

Map.create(
  game_id: 1,
  name: 'map 1',
  description: 'map for quest game',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Map.create(
  game_id: 1,
  name: 'map 2',
  description: 'map for quest game',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 1',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 2',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 3',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 4',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 5',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 6',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 7',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 8',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 9',
  description: 'scene for map 1',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 11',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 12',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 13',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 14',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 15',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 16',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 17',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 18',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 19',
  description: 'scene for map 2',
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'sky',
  tags: "['blue', 'sky']"
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'potter',
  tags: "['potter', 'sky']"
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'tree',
  tags: '[1, 2, 3, 4]'
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'tree',
  tags: '[bob, oak, wood]'
)


Entity.create!(
  obj: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'old hag',
  tags: "['guns', 'roses']"
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'grass',
  tags: "['green', 'short']"
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'pond',
  tags: "[water, small]"
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'rock',
  tags: '[big, grey, mossy]'
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'hollow tree',
  tags: '[birch, wood]'
)


Entity.create!(
  obj: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'Tall MAN',
  tags: "['pie', 'thing']"
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'red sky',
  tags: "['red', 'sky']"
)

Background.create!(
  obj: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'church',
  tags: "[steeple, stained glass, brick]"
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: false,
  name: 'tree',
  tags: '[1, 2, 3, 4]'
)

Obstacle.create!(
  obj: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'shrub',
  tags: '[green, short, stubby]'
)


Entity.create!(
  obj: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  public: true,
  name: 'tacopies',
  tags: "[stinky, man, short]"
)

Character.create!(
  user_id: 1,
  obj: '{name: guy, movements {up: {blah}, down: {blah}, swim: {blah}}}',
  name: 'tacopies',
  current: true
)

Character.create!(
  user_id: 1,
  obj: '{I am the almighty object}',
  name: 'churrocakes',
  current: false
)

Character.create!(
  user_id: 1,
  obj: '{object: {object: key of key}}',
  name: 'burritobrownies',
  current: false
)
