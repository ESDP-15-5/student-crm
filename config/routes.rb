Rails.application.routes.draw do
  get 'course_elements/show'

  root 'courses#index'


  resources :courses do
    resources :course_elements do
      get 'download/:id' =>  'course_elements#download', :as => :download
      resources :course_element_files
    end
  end



  devise_for :users
  # devise_scope :user do
  #   root :to => 'devise/sessions#new'
  # end

   # resources :users

  scope :manage do
    resources :users
  end

end
