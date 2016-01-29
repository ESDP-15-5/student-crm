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
  get 'users/teachers'

  get 'users/:id/change(.:format)' => 'users#changes', as: 'change_user'

  resources :contact_lists,
            :sms_deliveries,
            :sms_service_accounts,
            :senders

  resources :custom_lists do
    collection {post :import}
  end

  post 'sms_deliveries/:id/send' => 'sms_deliveries#send_message', as: 'sms_send_message'
  get 'select_objects/select_group/:id' => 'select_objects#select_group', as: 'select_groups'
  get 'select_objects/select_students/:id' => 'select_objects#select_students', as: 'select_students'
  get 'sms_deliveries/new_from_contact_list/:id' => 'sms_deliveries#new_from_contact_list', as: 'sms_new_from_contact_list'
  get 'sms_deliveries/resend_message/:id' => 'sms_deliveries#resend_message', as: 'sms_resend'

  resources :assignments

end
