class GroupsController < ApplicationController

    def get_initial_crums()
      {
          "Курсы"=> courses_path
      }
    end

    def index
      @course = Course.find(params[:course_id])
      @groups = @course.groups
    end

    def show
      @course = Course.find(params[:course_id])
      @group = Group.find(params[:id])
      @students = @group.students

      hash_crums = {
          @course.name => course_path(@course.id),
          @group.name => {}
      }

      @bread_crums = add_bread_crums(hash_crums)
    end

    def new
      @course = Course.find(params[:course_id])
      @group = @course.groups.build

      hash_crums = {
          @course.name => course_path(@course.id),
          "Создание новой группы" => {}
      }

      @bread_crums = add_bread_crums(hash_crums)
    end

    def create
      @course = Course.find(params[:course_id])
      @group = @course.groups.build(group_params)
      if @group.save
        flash[:notice] = "Группа #{@group.name} успешно создана!"
        redirect_to course_path(@course)
      else
        render 'new'
      end
    end

    def edit
      @course = Course.find(params[:course_id])
      @group = Group.find(params[:id])

      hash_crums = {
          @course.name => course_path(@course.id),
          "Редактирование группы #{@group.name}" => {}
      }

      @bread_crums = add_bread_crums(hash_crums)
    end

    def update
      @course = Course.find(params[:course_id])
      @group = Group.find(params[:id])
      if @group.update(group_params)
        flash[:notice] = 'Группа успешно обновлена!'
        redirect_to course_path(@course)
      else
        render 'edit'
      end
    end

    def destroy
      @course = Course.find(params[:course_id])
      @group = Group.destroy(params[:id])
      flash[:notice] = 'Группа успешно удалена!'
      redirect_to course_path(@course)
    end

    private

    def group_params
      params.require(:group).permit(:name, :id, :course_id, {:student_ids => []})
    end


end
