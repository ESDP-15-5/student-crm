class PeriodsController < ApplicationController
  def get_initial_crums()
    {
        "Занятия"=> courses_path
    }
  end

  def index
    @periods = Period.all
  end

  def new
    @periods = Period.new

    hash_crums = {
        "Создание нового Занятия" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)

  end

  def create
    @period = Period.new(course_params)

    if @course.save

      redirect_to @course
    else
      render 'new'
    end
  end


  private

  def period_params
    params.require(:period).permit(:title, :commence_datetime)
  end

end
