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

    if params[:group].nil?||params[:group][0].empty?
      @periods = Period.where(course_id: courses)
    else
      @periods = Period.where(group_id: params[:group])
    end

    hw_table_array = []
    @periods.order(course_id: :asc,commence_datetime: :asc).each do |period|
      assignments = Assignment.where(period_id: period.id)
      table_raw = {
          course: Course.find(period.course_id).name,
          period: period.title,
          period_id: period.id,
          group: Group.find(period.group_id).name,
          assignment: assignments,
          assignment_number_grades: assignments.where.not(grade: nil)
      }
      hw_table_array.push(table_raw)
    end

    @hw_table = hw_table_array.paginate(page: params[:page], per_page: 10)

    hash_crumbs = {
        'Домашние работы' => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def period
    period =Period.find(params[:id])
    @assignments = period.assignments
    hw_table_array=[]

    GroupMembership.where(group_id: Group.find(period.group_id)).each do |gr_member|
      table_raw = {
          user: gr_member.user.name,
          user_id: gr_member.user.id,
          assigment: Assignment.where(user_id: gr_member.user.id, period_id: period.id)
      }
      hw_table_array.push(table_raw)
    end

    @hw_table = hw_table_array.paginate(page: params[:page], per_page: 10)
    hash_crumbs = {
        'Домашние работы' => assignments_path,
        "Домашние работы к занятию #{period.title}" => {}
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

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      flash[:notice] = "Домашняя работа #{@assignment.name} успешно загружена!"
      redirect_to :back
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
