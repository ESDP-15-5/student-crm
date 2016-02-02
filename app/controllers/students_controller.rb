class StudentsController < ApplicationController
  def index
    @counter = 1
    @course = Course.find(params[:id])
    @group = @course.groups.first
    @students = @group.students
    @course_elements = Period.where(course_id: @course,group_id: @group).order('commence_datetime ASC')
    @time = Time.now
    p @time
  end

  def student_main_page
    @student = current_user
  end

end
