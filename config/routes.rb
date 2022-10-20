Rails.application.routes.draw do
  devise_for :users
  root 'trainings#index'
  resources :trainings do
    collection do
      get :mypage
    end
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
