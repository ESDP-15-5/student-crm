class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction, :role_sort_column

  def get_initial_crumbs()
    {
        "Пользователи"=> users_path
    }
  end

  def index
    scoped_users = User.all
    @users = User.search(params[:search], scoped_users).joins(:roles).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10).uniq
  end


  def new
    @user = User.new
    hash_crumbs = {
       "Создание нового пользователя" => {}
    }

    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def create
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    if @user.save
      flash[:notice] = 'Студент успешно добавлен'
      UserMailer.password_email(@user, generated_password).deliver_now

      redirect_to users_students_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    hash_crumbs = {
        "Обновление пользователя #{@user.email}" => {}
    }

    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      #Это для того чтобы пользователь при смене пароля оставался в системе
      if current_user.has_role? :student
      redirect_to user_path(current_user)
      else
        redirect_to users_students_path
      end

    else
      render 'edit'
    end

  end

  def show
    @user = User.find(params[:id])
    @members = GroupMembership.where(user_id: @user)
    # @courses=[]
    # @members.each do |m|
    #   @courses.push Course.where(id: Group.find(m.group_id).course_id)
    # end
      if @user.is_student?
        @group = Group.find_by_id(@members[0].group_id)
        @course = Course.find_by_id(@group.course_id)
      @practical_time = @course.practical_time
      @theoretical_time = @course.theoretical_time
      @educational_cost = @course.educational_cost
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ContractPdf.new(@user, view_context, @course, @practical_time, @theoretical_time, @educational_cost)
          send_data pdf.render, filename:
              "договор #{@user.created_at.strftime("%d.%m.%Y")}.pdf",
                    type: "application/pdf", disposition: "inline"
        end
      end
    end
  end

  def students
    @student_role = Role.find_by(name: 'student')

    @students = @student_role.users.paginate(page: params[:page], per_page: 10)
  end

  def teachers
    @teacher_role = Role.find_by(name: :teacher)
    @teachers = @teacher_role.users.paginate(page: params[:page], per_page: 10)
  end

  def managers
    @manager_role = Role.find_by(name: :manager)
    @managers = @manager_role.users.paginate(page: params[:page], per_page: 10)
  end

  def assistents
    @assistent_role = Role.find_by(name: :assistent)
    @assistents = @assistent_role.users.paginate(page: params[:page], per_page: 10)
  end

  def changes
    @user = User.find(params[:id])
    @audit = @user.audits
  end

  def destroy
    @user = User.find(params[:id])
    @group_membership = GroupMembership.where(:user_id => @user.id)
    @group_membership.destroy(@group_membership)
    @user.destroy
    redirect_to users_students_path
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
                                 :role_ids => [],
                                 :group_ids => [],
                                 contact_attributes: [:id, :phone, :additional_phone, :skype])
  end

  def sort_column
    # params[:sort] || "name"
    User.column_names.include?(params[:sort]) ? params[:sort] : 'role_id'
  end

  def role_sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    # params[:direction] || 'asc'
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end


end
