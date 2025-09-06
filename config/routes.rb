Rails.application.routes.draw do
  resources :themes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :managed_files, only: [:index, :show]
  root "managed_files#index"
  resources :managed_files, only: [:index, :show, :update] do
    get :content, on: :member
  end


end
