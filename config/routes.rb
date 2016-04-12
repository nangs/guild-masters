Rails.application.routes.draw do
  resources :monster_templates
  root to: 'application#index'
  resources :adventurers, only: [:create]
  resources :events, only: [:create]
  resources :facilities, only: [:create]
  resources :guild, only: [:create]
  resources :guildmaster, only: [:create]
  resources :quests, only: [:create]
  resources :accounts, only: [:create]
  resources :guild_sessions, only: [:create]
  delete 'sessions' => 'sessions#destroy'
  resources :sessions, only: [:create, :delete]

  namespace :admin do
    root to: 'dashboard#new'
    resources :adventurer_names
    resources :adventurer_templates
    resources :monster_templates
    resources :dashboard
  end
  get '*any', via: :all, to: 'errors#not_found'
  # get "*path", to: redirect('/')
end
