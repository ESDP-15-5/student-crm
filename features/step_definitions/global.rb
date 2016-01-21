# --------------------------------------course.feature
When(/^залогинен пользователь под "([^"]*)" с паролем "([^"]*)"$/) do |email, password|
  visit('/users/sign_in')
  within('#new_user') do
    fill_in 'user[email]', :with => email
    fill_in 'user[password]', :with => password
  end

  click_button('войти')

end

When(/^пользователь создает курс с данными "([^"]*)"$/) do |course_name|
  visit('/courses')
  visit('/courses/new')
  within('#new_course') do
     fill_in 'course[name]', :with => course_name
  end
  click_button('Создать курс')
end

When(/^"([^"]*)" появляется в списке курсов$/) do |course_name|
  visit('/courses')
  expect(page).to have_content(course_name)
end

When(/^пользователь удаляет курс с названием "([^"]*)"$/) do |course_name|
  visit('/courses')
  element = "//td//*[contains(text(), '" + course_name + "')]/ancestor::tr//*[contains(text(), 'Удалить')]"
  find(:xpath, element).click
  page.driver.browser.switch_to.alert.accept
end

When(/^в списке пропал курс с названием "([^"]*)"$/) do |course_name|
   page.should have_no_content(course_name)
end

When(/^Пользователь редактирует курс с названием "([^"]*)" на "([^"]*)"$/) do |course_name_old, course_name_new|
  visit('/courses')
  element = "//td//*[contains(text(), '" + course_name_old + "')]/ancestor::tr//*[contains(text(), 'Редактировать')]"
  find(:xpath, element).click
  within('.edit_course') do
    fill_in 'course[name]', :with => course_name_new
  end
  click_button('Обновить курс')
end
# --------------------------------------login.feature
When(/^я не залогиненный пользователь$/) do
  visit(root_path)
  expect(page).to have_css('form')
  expect(page).to have_content('Войти')
  find_button('войти').click
end

When(/^пользователь, зайдя на страницу "([^"]*)", увидет таблицу с курсами$/) do |name_page|
  visit("/#{name_page}")
  expect(page).to have_content('Курсы')
  expect(page).to have_selector('table')
  find_link('Выйти', :visible => :all).visible?
end

When(/^меня редиректит на страницу с авторизацией$/) do
  expect(page).to have_css('form')
  expect(page).to have_content('Войти')
  find_button('войти').click
end

When(/^пользователь зашел на главную страницу$/) do
  visit(root_path)
end

When(/^я зашел на страницы (.*)$/) do |pages_path|
  visit(eval(pages_path))
end


When(/^меня редиректит на страницу с авторизацией (.*)$/) do |redirect_path|
  expect(page).to have_css('form')
  expect(page).to have_content('Войти')
  find_button('Войти').click
end
# --------------------------------------course_element.feature
When(/^пользователь заходит в курс "([^"]*)"$/) do |course_name|
  # find(course_name).click
  visit('/courses')
  click_link(course_name)
end

When(/^он видит список элементов курса "([^"]*)"$/) do |course_name|
  expect(page).to have_content("Элементы курса #{course_name}")
  expect(page).to have_css('table')
end

When(/^пользователь нажимает на "([^"]*)"$/) do |button_name|
  click_link(button_name)
end


When(/^вводит в название элемента курса "([^"]*)"$/) do |theme|
  within('#new_course_element') do
    fill_in 'course_element[theme]', :with => theme
  end
end

When(/^выбирает тип элемента курса "([^"]*)"$/) do |type_element|
  within('#new_course_element') do
    select(type_element, :from => 'course_element[element_type]')
  end
end

When(/^пользователь нажимает на кнопку "([^"]*)"$/) do |button_name|
  find_button(button_name).click
end

When(/^"([^"]*)" появляется в списке элементов$/) do |course_element|
  expect(page).to have_content(course_element)
  expect(page).to have_selector('table')
  find_link('Выйти', :visible => :all).visible?
end


When(/^пользователь удаляет элемент курса с названием "([^"]*)"$/) do |element_course|
  element = "//td//*[contains(text(), '" + element_course + "')]/ancestor::tr//*[contains(text(), 'Удалить')]"
  find(:xpath, element).click
  page.driver.browser.switch_to.alert.accept
end

When(/^элемент курса "([^"]*)" пропадет из списка элементов$/) do |element_course|
  page.should have_no_content(element_course)
end

When(/^пользователь редактирует элемент курса  с названием "([^"]*)" на "([^"]*)"$/) do |course_element_name_old, course_element_new|
  element = "//td//*[contains(text(), '" + course_element_name_old + "')]/ancestor::tr//*[contains(text(), 'Обновить')]"
  find(:xpath, element).click
  within('.edit_course_element') do
    fill_in 'course_element[theme]', :with => course_element_new
  end
  click_button('Обновить элемент курса')
end
# --------------------------------------
When(/^пользователь переходит в курс (.*)$/) do |course|
  click_link(course)
  sleep(1)
end

When(/^пользователь переходит в элемент курса (.*)$/) do |course_element|
  click_link(course_element)
  sleep(1)
end

When(/^пользователь заходит в элемент курса "([^"]*)"$/) do |course_element|
  click_link(course_element)
end

When(/^он видит кнопку "([^"]*)"$/) do |button_name|
  sleep(3)
  find_link(button_name, :visible => :all).visible?
end


When(/^выбирает файл с локального ПК$/) do
  sleep(1)
  attach_file('course_element_file_file', Rails.root.join('features', 'upload-files', 'test_file.jpg'))
  sleep(1)
end


When(/^файл появляется в списке "([^"]*)"$/) do |file_name|
  expect(page).to have_content(file_name)
end

When(/^пользователь удаляет файл с названием "([^"]*)"$/) do |file_name|
  element = "//td//*[contains(text(), '" + file_name + "')]/ancestor::tr//*[contains(text(), 'Удалить')]"
  find(:xpath, element).click
  page.driver.browser.switch_to.alert.accept
end

When(/^файл "([^"]*)" пропадает из списка$/) do |file_name|
  page.should have_no_content(file_name)
end

# --------------------------------------course_material.feature

When(/^заполняет поле Заголовок материала "([^"]*)"$/) do |title|
  within('#new_course_element_material') do
    fill_in 'course_element_material[title]', :with => title
  end
  sleep(1)
end


When(/^его перекидывает на форму добавления материала$/) do
  expect(page).to have_css('#new_course_element_material')
end


When(/^отображается список с добавленным материалом "([^"]*)"$/) do |title|
  expect(page).to have_content(title)
  sleep(1)
end


When(/^пользователь находится на странице элемента курса "([^"]*)"$/) do |arg|
  visit('/courses/3/course_elements/2')
end

When(/^заполняет поле "([^"]*)"$/) do |text|

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
    CKEDITOR.instances['course_element_material_content'].setData(#{content});
    $('textarea#course_element_material_content').text(#{content});
    SCRIPT
  end

# Example:
  fill_in_ckeditor 'email_body', :with => 'This is my message!'

  sleep(1)
end

When(/^пользователь нажимает на button "([^"]*)"$/) do |button|
  click_button('Добавить Материал')
end

When(/^пользователь на странице редактирования материала "([^"]*)"$/) do |title|
  visit('/courses/3/course_elements/1/course_element_materials/1/edit')
  sleep(1)
end

When(/^он меняет содержимое поля "([^"]*)" => с "([^"]*)" на "([^"]*)"$/) do |title1, title2, title3|
  within('#edit_course_element_material_1') do
    fill_in 'course_element_material[title]', :with => title3
  end
end

When(/^содержимое поля "([^"]*)" => с "([^"]*)" на "([^"]*)"$/) do |title, content1, content2|

  def fill_in_ckeditor(locator, opts)
    content = opts.fetch(:with).to_json
    page.execute_script <<-SCRIPT
    CKEDITOR.instances['course_element_material_content'].setData(#{content});
    $('textarea#course_element_material_content').text(#{content});
    SCRIPT
  end

# Example:
  fill_in_ckeditor 'email_body', :with => content2

end

When(/^нажимает кнопку "([^"]*)"$/) do |button_name|
  click_button(button_name)
end

When(/^пользователь находится на странице отображения материалов у элемента курса "([^"]*)"$/) do |arg|
  visit('/courses/3/course_elements/1')
end

When(/^пользователь удаляет материал с названием "([^"]*)"$/) do |material_name|
  element = "//td//*[contains(text(), '" + material_name + "')]/ancestor::tr//*[contains(text(), 'Удалить')]"
  find(:xpath, element).click
  page.driver.browser.switch_to.alert.accept
end


When(/^материал элемента курса "([^"]*)" пропадет из списка$/) do |material_name|
  expect(page).not_to have_content(material_name)
end

When(/^он находится на странице элемента курса "([^"]*)"$/) do |course_element_name|
  visit('/courses/3/course_elements/1/')
  sleep(1)
end

When(/^пользователь нажал на кнопку "([^"]*)" материала "([^"]*)"$/) do |button_name, material_name|
  element = "//td//*[contains(text(), '" + material_name + "')]/ancestor::tr//*[contains(text(), '#{button_name}')]"
  find(:xpath, element).click
  sleep(1)
end

When(/^его перекидывает на форму изменения материала$/) do
  expect(page).to have_css('.edit_course_element_material')
  sleep(1)
end

When(/^пользователь видит измененное имя материала в таблице$/) do
  visit('/courses/3/course_elements/1')
  sleep(1)
end

When(/^он видит Выберите файл$/) do
  find(:xpath, '//*[@id="course_element_file_file"]')
end
