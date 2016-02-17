class SmsDeliveriesController < ApplicationController
  before_action :admin?

  def get_initial_crumbs()
    {
        "Рассылки"=> sms_deliveries_path
    }
  end

  def index
    @sms_deliveries = SmsDelivery.order(created_at: :desc).paginate(page: params[:page], per_page: 8)
  end

  def show
    @sms_delivery = SmsDelivery.find(params[:id])

    hash_crumbs = {
        @sms_delivery.title => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)
  end

  def resend_message
    @sms_delivery = SmsDelivery.find(params[:id])
    @sms_delivery = SmsDelivery.new(@sms_delivery.attributes)
    render :new
  end

  def new
    @sms_delivery = SmsDelivery.new

    hash_crumbs = {
        "Новая рассылка" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)

  end

  def new_from_contact_list
    @sms_delivery = SmsDelivery.new
    @contact_list = ContactList.find(params[:id])
    hash_crumbs = {
        "Новая рассылка" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)

  end

  def create
    @sms_delivery = SmsDelivery.new(sms_delivery_params)
    if @sms_delivery.save
      @sms_delivery.update_attribute(:delivery_time, Time.now + 3.minutes)
      flash[:success] = 'СМС рассылка будет отправлена через 3 минуты'
      redirect_to sms_deliveries_url

    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'new'
    end
  end

  def edit
    @sms_delivery = SmsDelivery.find(params[:id])
    hash_crumbs = {
        "Редактирование рассылки - #{@sms_delivery.title}" => {}
    }
    @bread_crumbs = add_bread_crumbs(hash_crumbs)

  end

  def update
    @sms_delivery = SmsDelivery.find(params[:id])
    if @sms_delivery.update(sms_delivery_params)
      @sms_delivery.updated_at + 3.minutes
      redirect_to sms_deliveries_url
      flash[:success] = 'Сообщение успешно отредактировано'
    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'edit'
    end
  end

  def destroy
    @sms_delivery = SmsDelivery.find(params[:id])
    @sms_delivery.destroy
    flash[:success] = 'Сообщение успешно удалено'
    redirect_to sms_deliveries_url
  end

  def send_message
    @sms_delivery = SmsDelivery.find(params[:id])
    @sms_delivery.update_attribute(:delivery_time, Time.now)
    send_sms(@sms_delivery)
  end

  private

  def sms_delivery_params
    params.require(:sms_delivery).permit(:title, :content, :contact_list_id, :sender_id)
  end

  def send_sms(object)
    path = '/api/message'
    xml_response = set_url(path, get_xml_format(object))
    response = Hash.from_xml(xml_response.body)
    case response['response']['status']
      when '0'
        @sms_delivery.update_attribute(:status, true)
        redirect_to sms_deliveries_url(resource_id: 1)
        flash[:success] = 'Сообщение Отправлено'

      when '1'
        flash[:danger] = 'Ошибка в формате запроса'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '2'
        flash[:danger] = 'Неверная авторизация'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '3'
        flash[:danger] = 'Недопустимый IP‐адрес отправителя'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '4'
        flash[:danger] = 'Недостаточно средств на счету'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '5'
        flash[:danger] = 'Недопустимое имя отправителя'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '6'
        flash[:danger] = 'Сообщение заблокировано по стоп‐словам'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '7'
        flash[:danger] = ' Некорректное написание одного или нескольких номеров'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '8'
        flash[:danger] = 'Неверный формат времени отправки'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '9'
        flash[:danger] = 'Отправка заблокирована из‐за срабатывания SPAM фильтра.'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '10'
        flash[:danger] = 'Отправка заблокирована  из‐за последовательного повторения id'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '11'
        flash[:danger] = 'Сообщение успешно обработано, но не принято к отправке и не протарифицировано 
т.к. в запросе был установлен параметр <test>1</test>'

        redirect_to sms_deliveries_url(resource_id: 1)
      else
        flash[:danger] = 'Ошибка отправки'

        redirect_to sms_deliveries_url(resource_id: 1)
    end

  end

  def get_xml_format(object)
    rand_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

    Nokogiri::XML::Builder.new do |xml|
      xml.message {
        xml.login(object.sender.sms_service_account.login)
        xml.pwd(object.sender.sms_service_account.password)
        xml.id(rand_string)
        xml.sender(object.sender.name)
        xml.text_ object.content
        xml.phones {

          if object.contact_list.custom_lists.any?
            object.contact_list.custom_lists.each do |phone|
              xml.phone(phone.phone)
            end
          else
            object.contact_list.users.each do |student|
              xml.phone(student.contact.phone)
            end
          end

        }
      }
    end
  end

  def build_report(object)
    rand_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    Nokogiri::XML::Builder.new do |xml|
      xml.dr {
        xml.login(object.sender.sms_service_account.login)
        xml.pwd(object.sender.sms_service_account.password)
        xml.id(rand_string)
      }
    end
  end




  def parse_report(xml)
    xml_doc = Nokogiri::XML(xml.body)
    xml_doc.remove_namespaces!
    doc = xml_doc.xpath('//phone')
    hash = {}
    doc.each do |phone|
      hash[phone.xpath('number').text] = phone.xpath('report').text
    end
    hash
  end

  private

  def set_url (url, message)
    http = Net::HTTP.new('smspro.nikita.kg')
    http.post(url, message.to_xml)
  end


end
