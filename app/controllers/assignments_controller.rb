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
    course_elements = CourseElement.where(course_id: courses)
    if params[:group].nil?||params[:group][0].empty?
      @periods = Period.where(course_element_id: course_elements)
    else
      @periods = Period.where(group_id: params[:group], course_element_id: course_elements)
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

  def rate
    assignment = Assignment.find(params[:id])
    if assignment.DownloadStatus
      if assignment.update(grade_params)
        flash[:success] = "Вы поставили #{assignment.grade}"
        redirect_to assignment_period_path(Period.find(assignment.period_id))
      else
        flash[:alert] = "Оценка не входит в диапазон от 0 до 100"
        redirect_to :back
      end
    else
      flash[:alert] = "Скачайте, пожалуйста, выбранную работу"
      redirect_to :back
    end

  end
  def review
    assignment = Assignment.find(params[:id])
    if assignment.DownloadStatus
      if assignment.update(review_params)
        flash[:success] = "Рецензия добавлена"
        redirect_to assignment_period_path(Period.find(assignment.period_id))
      else
        flash[:alert] = "Не удалось добавить рецензию"
        redirect_to :back
      end
    else
      flash[:alert] = "Скачайте, пожалуйста, выбранную работу"
      redirect_to :back
    end

  end

  def create
    assignment = Assignment.new(assignment_params)
    if assignment.save
      flash[:success] = "Домашняя работа успешно загружена!"
      redirect_to :back
    else
      flash[:alert] = "Вы можете прикрепить только zip, pdf, txt, doc"
      redirect_to :back
    end
  end

  def update
    assignment_update = Assignment.find(params[:id])
    if assignment_update.DownloadStatus.nil? || assignment_update.DownloadStatus && assignment_update.update(assignment_params)
      flash[:success] = 'Домашнее задание успешно заменено'
      redirect_to :back
    else
      flash[:alert] = 'Домашнюю работу уже скачал преподаватель'
      redirect_to :back
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
    download.DownloadStatus = true
    download.save
    flash[:notice] = 'Файл успешно скачан'
  end
  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :period_id, :file_version, :homework, :lesson_id)
  end

  def grade_params
    params.require(:assignment).permit(:grade)
  end

  def review_params
    params.require(:assignment).permit(:review)
  end
end
