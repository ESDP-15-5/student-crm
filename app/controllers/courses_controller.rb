class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save

      redirect_to @course
    else
      render 'new'
    end
  end

  def destroy
    @course = Course.destroy(params[:id])
    redirect_to root_url
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

end
