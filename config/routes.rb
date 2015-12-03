Rails.application.routes.draw do
  get 'course_elements/show'

  root 'courses#index'


  mount Ckeditor::Engine => '/ckeditor'
  resources :courses do
    resources :course_elements do
      post :update_row_order, on: :collection
      get 'download/:id' =>  'course_elements#download', :as => :download
      resources :course_element_files
      resources :course_element_materials
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
