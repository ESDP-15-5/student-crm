class CourseElementMaterialsController < ApplicationController

  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = @course_element.course_element_materials.build
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = @course_element.course_element_materials.build(course_element_material_params)

    if @course_element_material.save
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:id])
    @course_element_material = CourseElementMaterial.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.find(params[:id])

    if @course_element_material.update(course_element_material_params)
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.destroy(params[:id])
    redirect_to course_course_element_path(@course, @course_element)
  end

  private

  def course_element_material_params
    params.require(:course_element_material).permit(:course_id, :course_element_id, :title, :content)
  end




end
