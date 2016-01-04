class CourseElementMaterialsController < ApplicationController

  def get_initial_crums()
    {
        "Курсы"=> courses_path
    }
  end

  def show
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.find(params[:id])
    hash_crums = {
        @course.name => course_path(@course.id),
        @course_element.theme => course_course_element_path(@course.id, @course_element.id),
        @course_element_material.title => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def new
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = @course_element.course_element_materials.build

    hash_crums = {
        @course.name => course_path(@course.id),
        @course_element.theme => course_course_element_path(@course.id, @course_element.id),
        "Добавление материала" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def create
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = @course_element.course_element_materials.build(course_element_material_params)

    if @course_element_material.save
      flash[:notice] = "Раздаточный материал #{@course_element_material.title} успешно создан!"
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.find(params[:course_element_id])

    hash_crums = {
        @course.name => course_path(@course.id),
        @course_element.theme => course_course_element_path(@course.id, @course_element.id),
        "Обновление материала" => {}
    }

    @bread_crums = add_bread_crums(hash_crums)
  end

  def update
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.find(params[:id])

    if @course_element_material.update(course_element_material_params)
      flash[:notice] = 'Материал успешно обновлен!'
      redirect_to course_course_element_path(@course, @course_element)
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @course_element = CourseElement.find(params[:course_element_id])
    @course_element_material = CourseElementMaterial.destroy(params[:id])
    flash[:notice] = 'Материал успешно удален!'
    redirect_to course_course_element_path(@course, @course_element)
  end

  private

  def course_element_material_params
    params.require(:course_element_material).permit(:course_id, :course_element_id, :title, :content)
  end




end
