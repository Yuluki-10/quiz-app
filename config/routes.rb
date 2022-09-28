Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'trainings#index'
  resources :trainings do
    member do
      post :answer
    end
    resources :questions do
    end
  end
end
