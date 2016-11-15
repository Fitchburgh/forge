Rails.application.routes.draw do
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

  get 'games/user_games' => 'games#find_user_games'

  post 'games/savegame'

  post 'users/create'

  patch 'users/login'
end
