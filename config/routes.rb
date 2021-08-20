Rails.application.routes.draw do
  # namespace :users do
    resources :user_stockings, only: [:create, :destroy]
  # end
  devise_for :users, controllers:
  {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'welcome#index'
  get 'search_stock',to: 'stocks#search'

  get 'my_portfolio',to: 'stock_users#my_portfolio'
  get 'my_portfolio_path',to: 'stock_users#my_portfolio'

  get 'my_friends_path',to: 'stock_users#my_friends'
  get 'my_friends',to: 'stock_users#my_friends'

  get 'search_friend', to: 'stock_users#search'
  get 'search_friend_path', to: 'stock_users#search'


  resources :friendships, only: [:create, :destroy]
  resources :stock_users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
