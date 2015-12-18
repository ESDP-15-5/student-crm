class PeriodsController < ApplicationController
  def get_initial_crums()
    {
        "Курсы"=> courses_path
    }
  end

  def index
    @periods = Period.all
  end

  def show
    @period = Period.find(params[:id])

    hash_crums = {
        "Занятие #{@period.title}"=> {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.where('course_id = ?', params[:course_id])
    @group = Group.where('course_id = ?', params[:course_id])
    @period = Period.new

    hash_crums = {
        @course.name => course_path(@course.id),
        "Создание нового Занятия" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)

  end

  def create
    @period = Period.new(period_params)

    if @period.save

      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @period = Period.destroy(params[:id])
    redirect_to root_path
  end

  def edit
    @period = Period.find(params[:id])
    hash_crums = {
        "Обновление занятия #{@period.title}" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def update
    @period = Period.find(params[:id])

    if @period.update(period_params)
      redirect_to course_periods_path
    else
      render 'edit'
    end
  end


  private

  def period_params
    params.require(:period).permit(:group_id,:course_element_id,:title, :commence_datetime)
  end

end
