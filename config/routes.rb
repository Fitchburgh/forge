Rails.application.routes.draw do
  root '/'

  get 'games/index'

  post 'games/create'

  patch 'games/update'

  delete 'games/delete'

  get 'games/play'

  get 'games/search'

  post 'games/savegame'

  get 'games/restore' => 'games#restore'

  post 'users/create'
end
