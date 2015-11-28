Rails.application.routes.draw do
  get 'course_elements/show'

  root 'courses#index'


  resources :courses do
    resources :course_elements
  end



  devise_for :users
  # devise_scope :user do
  #   root :to => 'devise/sessions#new'
  # end

   resources :users


end
