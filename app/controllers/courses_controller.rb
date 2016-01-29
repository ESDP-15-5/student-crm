class CoursesController < ApplicationController
  def get_initial_crumbs()
    {
        "Курсы"=> courses_path
    }
  end

  def index
    @courses = Course.all
    @bread_crumbs = get_initial_crumbs()
  end

  def show
    @course = Course.find(params[:id])
    @course_elements = @course.course_elements.rank(:row_order)
    @groups = @course.groups

    hash_crumbs = {
        @course.name => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def new
    @course = Course.new

    hash_crumbs = {
        "Создание нового курса" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)

  end

  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:notice] = "Курс #{@course.name} успешно создан!"
      redirect_to @course
    else
      render 'new'
    end
  end

  def destroy
    @course = Course.destroy(params[:id])
    flash[:notice] = 'Курс успешно удален!'
    redirect_to root_url
  end

  def edit
    @course = Course.find(params[:id])
    hash_crumbs = {
        "Редактировать курс #{@course.name}" => {}
    }

    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      flash[:notice] = "Курс #{@course.name} успешно обновлен!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :practical_time, :theoretical_time, :starts_at, :ends_at, :educational_cost )
  end

end
