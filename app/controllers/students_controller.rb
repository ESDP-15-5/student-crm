class StudentsController < ApplicationController
  def index
    @counter = 1
    @counter_for_homework = 1
    @time = Time.now
    @course = Course.find(params[:id])
    @group =  current_user.groups.first
    @students = @group.students

    @course_elements = @course.course_elements.order(row_order: :ASC)
    @periods = Period.where(group_id: @group, deadline: true).where('commence_datetime <= ?', Date.tomorrow).order(commence_datetime: :ASC)

    @assignment_new = Assignment.new
  end

  def calendar_group
    @group = Group.find(params[:group_id])
    @periods = Period.where(group_id: @group.id)
  end

  def student_main_page

  end

end
