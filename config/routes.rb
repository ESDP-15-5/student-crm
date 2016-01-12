Rails.application.routes.draw do
  root 'courses#index'


  mount Ckeditor::Engine => '/ckeditor'

  resources :courses do
    resources :groups do
      resources :group_memberships
    end
    resources :periods
    resources :course_elements do
      post :update_row_order, on: :collection
      get 'download/:id' =>  'course_elements#download', :as => :download
      resources :course_element_files
      resources :course_element_materials
    end
  end

  devise_for :users

  scope :manage do
    resources :users
  end

  get 'users/students'
  get 'users/tutors'

  get 'users/:id/change(.:format)' => 'users#changes', as: 'change_user'





end
