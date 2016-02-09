class StudentsController < ApplicationController
  def index
    @counter = 1
    @counter_for_homework = 1
    @time = Time.now
    @course = Course.find(params[:id])
    @group =  current_user.groups.first
    @students = @group.students

    @course_elements = @course.course_elements.order(row_order: :ASC)
    # @periods = Period.where(group_id: @group, deadline: true).where('commence_datetime <= ?', Date.tomorrow).order(commence_datetime: :ASC)
    @periods = Period.where(group_id: @group, deadline: true).order(commence_datetime: :ASC)

    @assignment = Assignment.new
    @assignment_update = Assignment.find_by_user_id_and_period_id(current_user, @periods)
  end

  def calendar_group
    @group = Group.find(params[:group_id])
    @periods = Period.where(group_id: @group.id)
  end

  def student_main_page

  end

end
