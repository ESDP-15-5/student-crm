class CoursesController < ApplicationController
  def get_initial_crums()
    {
        "Курсы"=> courses_path
    }
  end

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @course_elements = @course.course_elements.rank(:row_order)
    @groups = @course.groups

    hash_crums = {
        "Элементы курса #{@course.name}"=> {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def new
    @course = Course.new

    hash_crums = {
        "Создание нового курса" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)

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
    hash_crums = {
        "Обновление курса #{@course.name}" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
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
