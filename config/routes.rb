# frozen_string_literal: true

Rails.application.routes.draw do
  get 'help/about'
  get 'help/contact'
  resources :other_events
  resources :officers
  resources :students
  resources :other_events
  resources :meetings
  resources :requests
  resources :meeting_participations
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  resources :requests do
    member do
      post 'accept'
      post 'deny'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'students#index'
end
