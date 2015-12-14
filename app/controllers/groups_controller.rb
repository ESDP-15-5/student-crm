class GroupsController < ApplicationController

    def get_initial_crums()
      {
          "Курсы"=> courses_path
      }
    end

    def show
      @course = Course.find(params[:course_id])
      @group = Group.find(params[:id])

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

      else
        render 'edit'
      end
      redirect_to course_path(@course)
    end

    def destroy
      @course = Course.find(params[:course_id])
      @group = Group.destroy(params[:id])
      redirect_to course_path(@course)
    end

    private

    def group_params
      params.require(:group).permit( :course_id, :name)
    end


end
