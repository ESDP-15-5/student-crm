class CourseElementFilesController < ApplicationController




  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build(course_element_file_params)

    if @course_element_file.save
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'new'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = CourseElementFile.destroy(params[:id])
    redirect_to course_course_element_path(@course, @course_element)
  end

  private

  def course_element_file_params
    params.require(:course_element_file).permit(:course_id, :course_element_id, :file)
  end




end
