class GroupMembershipsController < ApplicationController


  def new
    @group_membership = GroupMembership.new
    @course = Course.find(params[:course_id])
    @group = Group.find(params[:group_id])
    scoped_users = User.all
    @users = User.search(params[:search], scoped_users)
  end

  def create
    @course = Course.find(params[:course_id])
    @group = Group.find(params[:group_id])
    params[:group_membership][:user_id].each do |student_id|
      if student_id == ''
        next
      else
        GroupMembership.create!(group_id: params[:group_id], user_id: student_id)
      end
    end

    redirect_to course_group_path(@course, @group)
  end


end
