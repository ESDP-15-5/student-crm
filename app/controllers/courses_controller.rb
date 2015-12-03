class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @course_elements = @course.course_elements.rank(:row_order)
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
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

end
