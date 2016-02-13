class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin?
    redirect_to root_path unless current_user.has_role? :admin || :manager || :teacher
  end

  def student?
    redirect_to students_path if current_user.has_role? :student
  end


  def add_bread_crumbs(hash_crumbs)
    initial_crumbs = get_initial_crumbs
    new_crumbs = initial_crumbs.merge(hash_crumbs)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to main_app.root_url, :alert => exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.has_any_role? :admin, :manager, :teacher
      root_path
    elsif current_user.has_role? :student
      students_path
    end
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
