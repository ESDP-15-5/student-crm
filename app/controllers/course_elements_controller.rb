class CourseElementsController < ApplicationController

  def get_initial_crumbs()
    {
        "Курсы"=> courses_path
    }
  end

  def show
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
    @course_element_file = @course_element.course_element_files
    @course_element_material = @course_element.course_element_materials

    @course_element_file_new = CourseElementFile.new

    hash_crumbs = {
        @course.name => course_path(@course.id),
        @course_element.theme => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build

    hash_crumbs = {
        @course.name => course_path(@course.id),
        "Создание нового элемента курса" => {}
    }

    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build(course_element_params)

    if @course_element.save
      flash[:notice] = 'Элемент курса успешно создан!'
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])

    hash_crumbs = {
        @course.name => course_path(@course.id),
        "Обновление элемента курса #{@course_element.theme}" => {}
    }

    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def update
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
    if @course_element.update(course_element_params)
      flash[:notice] = 'Элемент курса успешно обновлен!'
      redirect_to course_path(@course)
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.destroy(params[:id])
    flash[:notice] = 'Элемент курса успешно удален!'
    redirect_to course_path(@course)
  end

  def update_row_order
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element.update_attribute :row_order_position, params[:row_order_position]

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end


  def download
    download = CourseElementFile.find(params[:id])
    send_file download.file.path,
              :filename => download.file_file_name,
              :type => download.file_content_type,
              :disposition => 'attachment'
    flash[:notice] = 'Your file has been downloaded'
  end

  private

  def set_course_element
    @course_element = CourseElement.find(params[:id])
  end

  def course_element_params
    params.require(:course_element).permit( :course_id, :theme, :element_type, :row_order_position )
  end
end
