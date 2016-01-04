class CourseElementFilesController < ApplicationController
  def get_initial_crums()
    {
        "Курсы"=> courses_path
    }
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build
    hash_crums = {
        @course.name => course_path(@course.id),
        @course_element.theme => course_course_element_path(@course.id, @course_element.id),
        "Добавление файла" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build(course_element_file_params)

    if @course_element_file.save
      # redirect_to course_course_element_path(@course, @course_element)
      flash[:notice] = 'Файл успешно загружен!'
      redirect_to :back
    else
      render 'new'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = CourseElementFile.destroy(params[:id])
    flash[:notice] = 'Файл успешно удален!'
    redirect_to course_course_element_path(@course, @course_element)
  end

  private

  def course_element_file_params
    params.require(:course_element_file).permit(:course_id, :course_element_id, :file)
  end

end
