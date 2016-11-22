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

  get 'collaborators/existence' => 'collaborators#check_collab_existence'
  get 'collaborators/game/collaborators-and-requesters' => 'collaborators#find_game_requesters_and_collaborators'
  get 'collaborators/game/requesters' => 'collaborators#find_game_requesters'
  get 'collaborators/game/collaborators' => 'collaborators#find_game_collaborators'
  get 'collaborators/user/collaborators' => 'collaborators#find_user_collaborators'
  get 'collaborators/user/requesters' => 'collaborators#find_user_requesters'
  post 'collaborators/create'
  patch 'collaborators/update/requested' => 'collaborators#update_requested_status'
  patch 'collaborators/update/accepted' => 'collaborators#make_collaborator'

  get 'entities/all' => 'entities#index'
  get 'entities/search'
  post 'entities/create'
  put 'entities/update'
  delete 'entities/delete'

  get 'events/index'
  get 'events/search'
  post 'events/create'
  put 'events/update'
  delete 'events/delete'

  root 'prelogin_users#welcome'
  get 'games/index'

  get 'games/search' => 'prelogin_users#search' # moved to prelogin controller
  get 'games/user-games' => 'games#find_user_games'
  get 'games/all' => 'prelogin_users#index'
  get 'games/load' => 'prelogin_users#load'
  get 'games/user-games/count' => 'games#find_user_games_count'
  get 'games/all/plays' => 'games#count_total_plays'
  get 'games/backgrounds/total' => 'games#count_total_backgrounds'
  get 'games/obstacles/total' => 'games#count_total_obstacles'
  get 'games/entities/total' => 'games#count_total_entities'
  get 'games/articles/total' => 'games#count_total_articles'
  get 'games/backgrounds/count' => 'games#count_backgrounds_by_game'
  get 'games/obstacles/count' => 'games#count_obstacles_by_game'
  get 'games/entities/count' => 'games#count_entities_by_game'
  get 'games/articles/count' => 'games#count_articles_by_game'
  get 'games/users/total' => 'games#count_game_users'
  post 'games/create'
  post 'games/savegame'
  patch 'games/plays' => 'prelogin_users#count'
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
  get 'users/plays' => 'games#check_user_play'
  get 'users/plays/count' => 'games#count_user_game_plays'
  get 'users/collaborations' => 'collaborators#find_collaborations_by_user' # finds all of a user's collaborations
  post 'users/plays' => 'games#add_user_play'
  post 'users/create' => 'prelogin_users#create'
  patch 'users/login' => 'prelogin_users#login'
  patch 'users/plays' => 'games#update_user_play'

  patch 'update/current/play' => 'users#update_current_play'
  patch 'update/current/edit' => 'users#update_current_edit'

  get 'users/current/play' => 'users#current_play'
  get 'users/current/edit' => 'users#current_edit'

  # rails routes for internal API views
  resources :admins

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get 'login' => 'sessions#new'
  post 'api/login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
