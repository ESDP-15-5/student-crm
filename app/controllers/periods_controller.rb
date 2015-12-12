class PeriodsController < ApplicationController
  def get_initial_crums()
    {
        "Занятия"=> periods_path
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
    @period = Period.new

    hash_crums = {
        "Создание нового Занятия" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)

  end

  def create
    @period = Period.new(period_params)

    if @period.save

      redirect_to @period
    else
      render 'new'
    end
  end

  def destroy
    @period = Period.destroy(params[:id])
    redirect_to periods_path
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
      redirect_to periods_path
    else
      render 'edit'
    end
  end


  private

  def period_params
    params.require(:period).permit(:title, :commence_datetime)
  end

end
