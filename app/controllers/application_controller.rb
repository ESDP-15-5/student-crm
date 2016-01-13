class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def add_bread_crums(hash_crums)
    initial_crums = get_initial_crums
    new_crums = initial_crums.merge(hash_crums)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :surname, :gender, :birthdate,
                                                            :passport_data, :email, :password, :password_confirmation,
                                                            contact_attributes:[:phone, :additional_phone, :skype]) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :surname, :gender, :birthdate,
                                                                   :passport_data, :email, :password, :password_confirmation,
                                                                   :current_password,
                                                                   contact_attributes:[:phone, :additional_phone, :skype]) }
  end


end
