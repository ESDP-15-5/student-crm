Rails.application.routes.draw do
  get 'course_element_material/index'

  get 'course_elements/show'

  root 'courses#index'


  resources :courses do
    resources :course_elements do
      resources :course_element_file
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
