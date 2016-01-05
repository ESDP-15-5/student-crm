class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def get_initial_crums()
    {
        "Пользователи"=> users_path
    }
  end

  def index
<<<<<<< HEAD
    @users = User.all
  end

  def destroy
    User.destroy(params[:id])
    flash[:notice] = 'Пользователь успешно удален!'
    redirect_to users_path
=======
    @users = User.paginate(page: params[:page], per_page: 10)
>>>>>>> origin/users
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

  def show
    @user = User.find(params[:id])
  end

  def students
    student_role = Role.find_by(name: 'student')

    @students = student_role.users.paginate(page: params[:page], per_page: 10)
  end

  def tutors
    tutor_role = Role.find_by(name: :tutor)
    @tutors = tutor_role.users.paginate(page: params[:page], per_page: 10)
  end

  def changes
    @user = User.find(params[:id])
    @audit = @user.audits
  end

  def destroy
    User.destroy(params[:id])
    redirect_to users_path
  end



  private

  def user_params
    params.require(:user).permit(:name,
                                 :surname,
                                 :middlename,
                                 :gender,
                                 :birthdate,
                                 :phone1,
                                 :phone2,
                                 :skype,
                                 :passportdetails,
                                 :email,
                                 :image,
                                 :password ,
                                 {:role_ids => []})
  end


end
