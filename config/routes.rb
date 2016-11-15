Rails.application.routes.draw do
  post 'articles/create'

  patch 'articles/update'

  delete 'articles/delete'

  get 'articles/search'

  root to: 'games#welcome'

  get 'games/index'

  post 'games/create'

  patch 'games/update'

  delete 'games/delete'

  get 'games/play'

  get 'games/search'

  post 'games/savegame'

  get 'games/restore' => 'games#restore'

  post 'users/create'

  patch 'users/login'
end
