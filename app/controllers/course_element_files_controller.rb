class CourseElementFilesController < ApplicationController



  def show
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_files = @course_element.course_element_files
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = @course_element.course_element_files.build(course_element_file_params)

    if @course_element_file.save
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = CourseElementFile.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = CourseElementFile.find(params[:id])
    if @course_element_file.update(course_element_file_params)

    else
      render 'edit'
    end
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_file = CourseElementFile.destroy(params[:id])
    redirect_to course_course_element_path(@course_element)
  end

  private

  def course_element_file_params
    params.require(:course_element_file).permit(:course_id, :course_element_id, :file)
  end




end
