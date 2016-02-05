class StudentsController < ApplicationController
  def index
    @counter = 1
    @time = Time.now
    @course = Course.find(params[:id])
    @group =  current_user.groups.first
    @students = @group.students
    @course_elements = CourseElement.where(course_id: @course).order(row_order: :ASC)
    @periods = Period.where(course_id: @course,group_id: @group).order('commence_datetime ASC')
    @assignment = Assignment.new

  end

  def calendar_group
    @group = Group.find(params[:group_id])
    @periods = Period.where(group_id: @group.id)
  end

  def student_main_page

  end

end
