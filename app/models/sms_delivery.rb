class SmsDelivery < ActiveRecord::Base
  belongs_to :contact_list
  belongs_to :sender

  before_validation :fill_title

  validates :title, presence: true, length: { maximum: 70 }
  validates :content, presence: true, length: { maximum: 800 }
  validates :contact_list, presence: true
  validates :sender, presence: true

  def send_message
    url = '/api/message'
    @response = set_url(url, build_message)
    update_attribute(:status, true)
  end

  def build_message
    Nokogiri::XML::Builder.new do |xml|
      xml.message {
        xml.login(sender.sms_service_account.login)
        xml.pwd(sender.sms_service_account.password)
        xml.id(id.to_s + 'importecsdm')
        xml.sender(sender.name)
        xml.text_ content
        xml.phones {

          if contact_list.custom_lists.any?
            contact_list.custom_lists.each do |phone|
              xml.phone(phone.phone)
            end
          else
            contact_list.users.each do |student|
              xml.phone(student.contact.phone)
            end
          end

        }
      }
    end
  end

  def build_report
    Nokogiri::XML::Builder.new do |xml|
      xml.dr {
        xml.login('aisma')
        xml.pwd('kiminitodoke')
        xml.id(id.to_s + 'Mesp1502')
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

  def fill_title
    if self.title.blank?
      self.title = self.content[0, 69]
    end
  end
end
