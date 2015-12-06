class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def add_bread_crums(hash_crums)
    initial_crums = get_initial_crums
    new_crums = initial_crums.merge(hash_crums)
  end
end
