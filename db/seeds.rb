User.create(
  username: 'fitchburgh',
  token: 'asoidaiosdjgas8235hy09130t1h3tQahg8123450176304',
  uid: "12498720913851029",
  google_oauth_data: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  playing_game: 1,
  editing_game: 1
)

User.create(
  username: 'natedawg',
  token: 'alksdjfffi43mfl3k43m4kl3l4mr34f90sjc',
  uid: "8675309",
  google_oauth_data: "{'this guy': 'such a cool dude'}",
  playing_game: 1,
  editing_game: 1
)

User.create(
  username: 'bignate',
  token: 'a000aaa0a0a0a00aaa00a0a0a0a00a0a0a00a0a',
  uid: "123456789987654321",
  google_oauth_data: "{'best attributes': ['rad', 'cool', 'handsome']}",
  playing_game: 1,
  editing_game: 1
)

User.create(
  username: 'chewy',
  token: '22222222222222222222222llllllllllllllllll',
  uid: "99999988888888777777766666666",
  google_oauth_data: "{'ggggrrrrrrr': 'grrrrrr'}",
  playing_game: 1,
  editing_game: 1
)

# These seeds needs to exist in production
###################################

Game.create(
  id: 0,
  name: 'Orphans',
  tags: '[]',
  user_id: 1,
  description: 'Where all the orphan articles live',
  info: "{Orphan: game}",
  archived: false,
  plays: 0,
  score: 150
)

###################################

Game.create(
  name: 'quest',
  tags: '[war, fight, adventure]',
  user_id: 1,
  description: 'test descript',
  info: "{'some': 'text', 'goes': 'here'
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
  }",
  published: true,
  archived: false,
  plays: 10,
  score: 100
)

Collaborator.create(
  game_id: 1,
  user_id: 1,
  requested: true,
  accepted: true,
)

Collaborator.create(
  game_id: 1,
  user_id: 2,
  requested: true,
  accepted: true,
)

Collaborator.create(
  game_id: 1,
  user_id: 3,
  requested: true,
  accepted: false,
)

Collaborator.create(
  game_id: 1,
  user_id: 4,
  requested: true,
  accepted: true,
)

Map.create(
  game_id: 1,
  name: 'map 1',
  description: 'map for quest game',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Map.create(
  game_id: 1,
  name: 'map 2',
  description: 'map for quest game',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 1',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 2',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 3',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 4',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 5',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 6',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 7',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 8',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 1,
  game_id: 1,
  name: 'scene 9',
  description: 'scene for map 1',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 11',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 12',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 13',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 14',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 15',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 16',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 17',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 18',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Scene.create(
  map_id: 2,
  game_id: 1,
  name: 'scene 19',
  description: 'scene for map 2',
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'sky',
  tags: "['blue', 'sky']"
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'potter',
  tags: "['potter', 'sky']"
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'tree',
  tags: '[1, 2, 3, 4]'
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'tree',
  tags: '[bob, oak, wood]'
)


Entity.create!(
  info: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'old hag',
  tags: "['guns', 'roses']"
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'grass',
  tags: "['green', 'short']"
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'pond',
  tags: "[water, small]"
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'rock',
  tags: '[big, grey, mossy]'
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'hollow tree',
  tags: '[birch, wood]'
)


Entity.create!(
  info: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'Tall MAN',
  tags: "['pie', 'thing']"
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'red sky',
  tags: "['red', 'sky']"
)

Background.create!(
  info: "{'some': 'text', 'goes': 'here' {'sometimes': 'its', 'really' {'complicated' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'church',
  tags: "[steeple, stained glass, brick]"
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: false,
  name: 'tree',
  tags: '[1, 2, 3, 4]'
)

Obstacle.create!(
  info: "{'foo': 'bar', 'taco': 'pie' {'hi': 'mom', 'please' {'help' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'shrub',
  tags: '[green, short, stubby]'
)


Entity.create!(
  info: "{'a': 'b', 'c': 'd' {'e': 'f', 'g' {'fun' {[1, 2, 3, 4, 5]}}}}",
  user_id: 1,
  game_id: 1,
  published: true,
  name: 'tacopies',
  tags: "[stinky, man, short]"
)

Character.create!(
  user_id: 1,
  info: '{name: guy, movements {up: {blah}, down: {blah}, swim: {blah}}}',
  name: 'tacopies',
  current: true
)

Character.create!(
  user_id: 1,
  info: '{I am the almighty object}',
  name: 'churrocakes',
  current: false
)

Character.create!(
  user_id: 1,
  info: '{infostuff: {info: key of key}}',
  name: 'burritobrownies',
  current: false
)
