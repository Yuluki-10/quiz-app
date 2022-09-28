Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'trainings#index'
  resources :trainings do
    resources :questions do
      collection do
        post :answer
        get :result
      end
    end
  end
end
