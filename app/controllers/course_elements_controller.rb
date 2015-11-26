class CourseElementsController < ApplicationController
  def show
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build(course_element_params)

    if @course_element.save
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.destroy(params[:id])
    redirect_to course_path(@course)
  end

  private

  def course_element_params
    params.require(:course_element).permit( :theme, :element_type)
  end
end
