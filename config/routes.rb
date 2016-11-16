Rails.application.routes.draw do
  post 'scenes/create'

  get 'scenes/index'

  get 'scenes/search'

  post 'maps/create'

  get 'maps/index'

  get 'maps/search'

  get 'articles/index'

  get 'articles/backgrounds' => 'articles#index_backgrounds'

  get 'articles/obstacles' => 'articles#index_obstacles'

  get 'articles/entities' => 'articles#index_entities'

  post 'articles/create'

  patch 'articles/update'

  delete 'articles/delete'

  get 'articles/search'

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
