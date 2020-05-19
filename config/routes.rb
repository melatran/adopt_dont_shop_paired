Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:id/pets', to: 'shelters#pets'

  get '/pets', to: 'pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'
  get '/pets/:id', to: 'pets#show'
  put '/pets/:id', to: 'pets#approve'

  get '/shelters/:shelter_id/new_review', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/:id', to: 'reviews#destroy'

  get '/favorites', to: 'favorites#index'
  get '/favorites/remove_all', to: 'favorites#remove_all'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/:pet_id', to: 'favorites#destroy'

  get '/pets/:id/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'
end
