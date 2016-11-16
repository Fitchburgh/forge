Rails.application.routes.draw do
  get 'characters/search'

  post 'characters/create'

  delete 'characters/delete'

  put 'characters/update'

  post 'scenes/create'

  get 'scenes/index'

  get 'scenes/search'

  post 'maps/create'

  get 'maps/index'

  get 'maps/search'

  get 'articles/index'

  get 'articles/search'

  get 'backgrounds/index'

  get 'obstacles/index'

  get 'entities/index'

  post 'backgrounds/create'

  post 'obstacles/create'

  post 'entities/create'

  put 'backgrounds/update'

  put 'obstacles/update'

  put 'entities/update'

  delete 'backgrounds/delete'

  delete 'obstacles/delete'

  delete 'entities/delete'

  root to: 'games#welcome'

  get 'games/index'

  post 'games/create'

  put 'games/update'

  delete 'games/delete'

  get 'games/search'

  get 'games/user-games' => 'games#find_user_games'

  post 'games/savegame'

  post 'users/create'

  patch 'users/login'
end
