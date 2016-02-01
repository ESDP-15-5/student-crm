class ContactListsController < ApplicationController
  before_action :admin?

  def get_initial_crumbs()
    {
        "Листы получателей"=> contact_lists_path
    }
  end

  def index
    @contact_lists = ContactList.all
  end

  def show
    @contact_list = ContactList.find(params[:id])

    hash_crumbs = {
        @contact_list.title => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def new
    @contact_list = ContactList.new
    hash_crumbs = {
        "Новый лист получателей"=> {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def create
    @contact_list = ContactList.new(contact_list_params)
    if @contact_list.save
      redirect_to contact_lists_url
      flash[:success] = 'Список получателей успешно создан'
    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'new'
    end
  end

  def edit
    @contact_list = ContactList.find(params[:id])
    hash_crumbs = {
        "Редактирование листа получателей - #{@contact_list.title}"=> {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def update
    @contact_list = ContactList.find(params[:id])

    if @contact_list.update(contact_list_params)
      flash[:success] = 'Список получателей успешно обновлен'
      redirect_to contact_lists_url
    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'edit'
    end
  end

  def destroy
    @contact_list = ContactList.find(params[:id])
    @contact_list.destroy
    flash[:success] = 'Список получателей удален'

    redirect_to contact_lists_url
  end

  private

  def contact_list_params
    params.require(:contact_list).permit(:title, user_ids: [])
  end
end
