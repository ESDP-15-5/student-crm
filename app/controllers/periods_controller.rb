class PeriodsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

def get_initial_crums()
    {
        "Курсы"=> courses_path
    }
  end

  def index
    @course = Course.find(params[:course_id])
    @course_elements = CourseElement.where(course_id: @course).order(:row_order)
    @groups = Group.where(course_id: @course)
    @period = Period.new
    @button_text = 'Создать занятие'

    @periods = Period.where(group_id: @groups)
    hash_crums = {
        @course.name => course_path(@course),
        'Календарь'=>{}
    }
    @bread_crums = add_bread_crums(hash_crums)
  end

  def show
    @period = Period.find(params[:id])

    hash_crums = {
        "Занятие #{@period.title}"=> {}
    }
    @bread_crums = add_bread_crums(hash_crums)
  end

  def create
    @course = Course.find(params[:course_id])
    @period = @course.periods.build(period_params)

    if @period.save
      flash[:notice] = 'Занятие успешно создано!'
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @period = Period.destroy(params[:id])
    flash[:notice] = 'Занятие успешно удалено!'
    redirect_to root_path
  end

  def edit
    @course = Course.find(params[:course_id])
    @period = Period.find(params[:id])
    @course_elements = @course.course_elements.order(:row_order)
    @groups = @course.groups
    @button_text = 'Обновить занятие'
    render 'index'

    hash_crums = {
        "Обновление занятия #{@period.title}" => {}
    }
    @bread_crums = add_bread_crums(hash_crums)
  end

  def update
    @period = Period.find(params[:id])

    if @period.update(period_params)
      flash[:notice] = 'Занятие успешно обновлено!'
      redirect_to :back
    else
      render 'edit'
    end
  end


  private

  def period_params
    params.require(:period).permit(:group_id,:course_element_id,:title, :commence_datetime)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @period = Period.find(params[:id])
  end

end
