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
    element_types = ['Лекция','Контрольная']
    course_elements = CourseElement.where(course_id: courses, element_type: element_types)
    if params[:group].nil?||params[:group][0].empty?
      @periods = Period.where(course_element_id: course_elements)
    else
      @periods = Period.where(group_id: params[:group],course_element_id: course_elements)
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
        'Домашние работы' => assignments_path(course: period.course.id),
        "Домашние работы к занятию #{period.title}" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def show
    @assignment = Assignment.find(params[:id])

     if params[:grade].to_i == 1
       @grade = 1
     end
     if params[:review].to_i == 1
       @grade = 0
     end

    hash_crumbs = {
        "Домашние работы к занятию #{@assignment.period.title}" => assignment_period_path(@assignment.period),
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def rate
    @assignment = Assignment.find(params[:id])

    if @assignment.update(grade_params)
      flash[:notice] = "Вы поставили #{@assignment.grade}"
      redirect_to assignment_period_path(Period.find(@assignment.period_id))
    else
      render 'grade'
    end
  end
  def review
    @assignment = Assignment.find(params[:id])

    if @assignment.update(review_params)
      flash[:notice] = "Рецензия добавлена"
      redirect_to assignment_period_path(Period.find(@assignment.period_id))
    else
      render 'review'
    end
  end
  def create
    @assignment = Assignment.new(assignment_params)
    $file = params[:assignment][:homework]
    $lesson_id = params[:assignment][:lesson_id]
    @assignment.lesson_id = $lesson_id
    if @assignment.save
      flash[:notice] = "Домашняя работа #{@assignment.name} успешно загружена!"
      redirect_to :back
    else
      render 'new'
    end
  end

  def update
    @assignment_update = Assignment.find_by_user_id_and_period_id(params[:id], params[:assignment][:period_id])
    $lesson_id = params[:assignment][:lesson_id]
    @assignment_update.lesson_id = $lesson_id
    if @assignment_update.update(assignment_params)
      flash[:success] = 'Домашнее задание успешно заменено'

      redirect_to :back
    else
      render 'index'
    end

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
    params.require(:assignment).permit(:user_id, :period_id,:name, :homework, :lesson_id)
  end

  def grade_params
    params.require(:assignment).permit(:grade)
  end

  def review_params
    params.require(:assignment).permit(:review)
  end
end
