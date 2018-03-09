Rails.application.routes.draw do
  get 'welcome/index'

  resources :patients

  root 'welcome#index'
end
