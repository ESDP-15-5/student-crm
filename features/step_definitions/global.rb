When(/^залогинен пользователь под "([^"]*)" с паролем "([^"]*)"$/) do |email, password|
  visit('/users/sign_in')
  within('#new_user') do
    fill_in 'user[email]', :with => email
    fill_in 'user[password]', :with => password
  end
  click_button('Войти')
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
  page.has_content?(course_name)
end

When(/^пользователь удаляет курс с названием "([^"]*)"$/) do |course_name|
  visit('/courses')
  element = "//td//*[contains(text(), '" + course_name + "')]/ancestor::tr//*[contains(text(), 'Удалить')]"
  find(:xpath, element).click
  page.driver.browser.switch_to.alert.accept
  sleep(2)
end

When(/^в списке пропал курс с названием "([^"]*)"$/) do |course_name|
  page.has_no_content?(course_name)
end

When(/^Пользователь редактирует курс с названием "([^"]*)" на "([^"]*)"$/) do |course_name_old, course_name_new|
  visit('/courses')
  element = "//td//*[contains(text(), '" + course_name_old + "')]/ancestor::tr//*[contains(text(), 'Редактировать')]"
  find(:xpath, element).click
  within('.edit_course') do
    fill_in 'course[name]', :with => course_name_new
  end
  sleep(5)
  click_button('Обновить курс')
  sleep(2)
end
