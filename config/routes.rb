Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/search'

  get 'backgrounds/index'
  post 'backgrounds/create'
  put 'backgrounds/update'
  delete 'backgrounds/delete'

  get 'characters/index'
  get 'characters/current_character'
  post 'characters/create'
  put 'characters/update'
  delete 'characters/delete'

  get 'entities/index'
  post 'entities/create'
  put 'entities/update'
  delete 'entities/delete'

  root to: 'games#welcome'
  get 'games/index'
  get 'games/search'
  get 'games/user-games' => 'games#find_user_games'
  post 'games/create'
  post 'games/savegame'
  put 'games/update'
  delete 'games/delete'

  get 'maps/index'
  get 'maps/search'
  post 'maps/create'

  get 'obstacles/index'
  post 'obstacles/create'
  put 'obstacles/update'
  delete 'obstacles/delete'

  get 'scenes/index'
  get 'scenes/search'
  post 'scenes/create'

  post 'users/create'
  patch 'users/login'
end
