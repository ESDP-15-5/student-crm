#language:ru
Функция: Управление смс-аккаунтом и листом получателей
  Как администратор системы
  Я хочу иметь возможность создавать,удалять аккаунт,добавлять отправителя,создавать лист получателей.

  Сценарий: Администратор создает аккаунт с отправителем
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь переходит на страницу создания аккаунта
    И пользователь заполняет поля формы
      | field                      | value       |
      | sms_service_account_login | test_login |
      | sms_service_account_password | test_password |
      | sms_service_account_senders_attributes_0_name | 996550123456 |
    И пользователь нажимает на кнопку "Создать"
    То он видит таблицу с данными аккаунта "test_login"

  Сценарий: Администратор редактирует аккаунт добавляет отправителя
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей аккаунтов
    Если пользователь редактирует данные у "faridbabazov"
    И пользователь заполняет поля формы
      | field                      | value       |
      | sms_service_account_password | eAswyztN |
      | sms_service_account_senders_attributes_0_name | 996772183644 |
    И пользователь нажимает на кнопку "Редактировать"

  Сценарий: Администратор удаляет аккаунт
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей аккаунтов
    Если пользователь удаляет аккаунт "faridbabazov"
    То аккаунт "faridbabazov" пропадает из таблицу
  @wip
  Сценарий: Администратор создает лист получателей
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей получателей
    Если пользователь нажимает на "Новый лист"
    И заполняет поле Название "Новые лист получателей"
    И выбирает студента "Иванов Иван Иваныч"
    И нажимает кнопку "Сохранить"
    То он видит таблицу получателей с названием "Новые лист получателей"

  Сценарий: Администратор редактирует лист получателей
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей получателей
    Если пользователь редактирует лист получателей "Лист получателей"
    И выбирает студента "Иванов Иван Иваныч"
    И нажимает кнопку "Сохранить"
    То он видит таблицу получателей с названием "Лист получателей"

  Сценарий: Администратор удаляет лист получателей
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей получателей
    Если пользователь удаляет лист получателей "Лист получателей"
    То лист получателей с названием "Лист получателей" пропадает из списка таблиц

  Сценарий: Администратор просматривает лист получателей
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей получателей
    Если пользователь нажимает на "Лист получателей"
    То он видит список пользователей кому будет отослана смс

  Сценарий: Администратор отправляет смс получателю(ям)
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь на странице с таблицей получателей
    Если пользователь нажимает у "Лист получателей" иконку "смс"
    То пользователь заполняет поля формы
      | field                      | value       |
      | text-field | Привет! Это послание прислано с сервера |
      | sms_delivery_title | Новое сообщение группе Рубистов |
    И нажимает кнопку "Сохранить"