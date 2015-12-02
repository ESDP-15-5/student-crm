class CourseElementsController < ApplicationController
  def show
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
    @course_element_file = CourseElementFile.where("course_element_id = ?", params[:id])
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = @course.course_elements.build(course_element_params)

    if @course_element.save
      redirect_to course_path(@course)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
    if @course_element.update(course_element_params)

    else
      render 'edit'
    end
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.destroy(params[:id])
    redirect_to course_path(@course)
  end

  def download
    upload = CourseElementFile.find(params[:id])
    send_file upload.file.path,
              :filename => upload.file_file_name,
              :type => upload.file_content_type,
              :disposition => 'attachment'
    flash[:notice] = "Your file has been downloaded"
  end

  private

  def course_element_params
    params.require(:course_element).permit( :course_id, :theme, :element_type,)
  end
end
