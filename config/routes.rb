Rails.application.routes.draw do

  use_doorkeeper
  namespace :v1 do
    jsonapi_resources :suits, only: [:index, :show, :options]
    jsonapi_resources :ranks, only: [:index, :show, :options]
    jsonapi_resources :cards, only: [:index, :show, :options]
    jsonapi_resources :table_rule_sets
    jsonapi_resources :tables
    jsonapi_resources :table_player_positions
    jsonapi_resources :users
    jsonapi_resources :players
  end

end
