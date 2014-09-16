Rails.application.routes.draw do
  root :to => "qualifications#index"

  resources :qualifications
end
