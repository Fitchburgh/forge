Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/search'
  get 'articles/game/all' => 'articles#find_game_articles'

  get 'backgrounds/all' => 'backgrounds#index'
  get 'backgrounds/search'
  post 'backgrounds/create'
  put 'backgrounds/update'
  delete 'backgrounds/delete'

  get 'characters/all' => 'characters#index'
  get 'characters/current_character'
  post 'characters/create'
  patch 'characters/update' => 'characters#update_current_character'
  put 'characters/update'
  delete 'characters/delete'

  get 'entities/all' => 'entities#index'
  get 'entities/search'
  post 'entities/create'
  put 'entities/update'
  delete 'entities/delete'

  root 'games#welcome'
  get 'games/index'

  get 'games/search'
  get 'games/user-games' => 'games#find_user_games'
  get 'games/all' => 'prelogin_users#index'
  get 'games/load' => 'prelogin_users#load'
  get 'games/user-games/count' => 'games#find_user_games_count'
  get 'games/all/plays' => 'games#count_total_plays'
  post 'games/create'
  post 'games/savegame'
  patch 'games/total-plays' => 'prelogin_users#count'
  put 'games/update'
  delete 'games/archive' => 'games#delete'

  get 'maps/all' => 'maps#index'
  get 'maps/search'
  post 'maps/create'

  get 'obstacles/all' => 'obstacles#index'
  get 'obstacles/search'
  post 'obstacles/create'
  put 'obstacles/update'
  delete 'obstacles/delete'

  get 'scenes/all' => 'scenes#index'
  get 'scenes/search'
  post 'scenes/create'

  get 'users/total' => 'games#count_users'
  post 'users/create'
  patch 'users/login'
end
