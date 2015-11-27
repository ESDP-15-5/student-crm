class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def destroy
    User.destroy(params[:id])
    redirect_to users_path
  end

end
