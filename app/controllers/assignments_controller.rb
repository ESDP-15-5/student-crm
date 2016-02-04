class AssignmentsController < ApplicationController
  def get_initial_crumbs()
    {
        "Курсы"=> courses_path
    }
  end
  def index
    if params[:course].nil? || params[:course][0].blank?
      courses = Course.all
    else
      courses = Course.find(params[:course])
    end

    hw_table_array = []
    courses.each do |course|
      if params[:group].nil?||params[:group][0].empty?
        @periods = course.periods
      else
        @periods = course.periods.where(group_id: params[:group])
      end

      @periods.each do |period|
        # add check for emty deadline
        GroupMembership.where(group_id: Group.find(period.group_id)).each do |gr_member|
          table_raw = {
              course: course.name,
              period: period.title,
              group: Group.find(period.group_id).name,
              user: gr_member.user.name,
              assigment: Assignment.where(user_id: gr_member.user.id, period_id: period.id)
          }
          hw_table_array.push(table_raw)
        end
      end
    end
    @hw_table = hw_table_array.paginate(page: params[:page], per_page: 10)

    hash_crumbs = {
        'Домашние работы' => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def show
    if params[:period_id]
      @assignments = Assignment.where(period_id: params[:period_id])
    else
      @assignment = Assignment.find(params[:id])
    end

    hash_crumbs = {
        @assignment.name => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def new
    @assignment = Assignment.new
    gr_members = GroupMembership.find_by(user_id: current_user.id)
    @group = Group.find(gr_members.group_id)
    @periods = @group.periods

    hash_crumbs = {
        "Создание нового курса" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.user_id = current_user.id
    if @assignment.save
      flash[:notice] = "Домашняя работа #{@assignment.name} успешно загружена!"
      redirect_to @assignment
    else
      render 'new'
    end
  end
  def edit

  end

  def update

  end

  def destroy
    @assignment = Assignment.destroy(params[:id])
    flash[:notice] = 'Домашняя работа успешно удалена!'
    redirect_to @assignment
  end

  def download
    download = Assignment.find(params[:id])
    send_file download.homework.path,
              :filename => download.homework_file_name,
              :type => download.homework_content_type,
              :disposition => 'attachment'
    flash[:notice] = 'Your file has been downloaded'
  end
  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :period_id,:name, :homework)
  end
end
