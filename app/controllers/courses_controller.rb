class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    course_id = params[:id]
    @course_elements = CourseElement.where("id = ?", course_id)
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

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)

    else
      render 'edit'
    end
    redirect_to root_url
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

end
