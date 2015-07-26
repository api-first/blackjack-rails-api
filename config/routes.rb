Rails.application.routes.draw do

  namespace :v1 do
    jsonapi_resources :suits, only: [:index, :show, :options]
  end

end
