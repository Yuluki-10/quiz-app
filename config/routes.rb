Rails.application.routes.draw do
  get 'chapters/new'
  get 'chapters/edit'
  get 'chapters/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'trainings#index'
  resources :trainings do
    resources :chapters do
      resources :questions do
        collection do
          post :answer
          get :result
        end
      end
    end
  end
end
