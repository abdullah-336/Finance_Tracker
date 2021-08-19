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
get 'my_portfolio',to: 'stock_users#my_portfolio'
get 'search_stock',to: 'stocks#search'
get 'my_portfolio_path',to: 'stock_users#my_portfolio'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
