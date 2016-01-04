class UsersController < ApplicationController
  def get_initial_crums()
    {
        "Пользователи"=> users_path
    }
  end

  def index
    @users = User.all
  end

  def destroy
    User.destroy(params[:id])
    flash[:notice] = 'Пользователь успешно удален!'
    redirect_to users_path
  end

  def new
    @user = User.new
    hash_crums = {
       "Создание нового пользователя" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Пользователь #{@user.name} успешно создан!"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    hash_crums = {
        "Обновление пользователя #{@user.email}" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'Пароль успешно сменён!'
      redirect_to users_path
      sign_in @user, :bypass => true
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation )
  end


end
