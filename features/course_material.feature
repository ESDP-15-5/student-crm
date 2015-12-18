#language:ru

Функция: Добавление материала(course_element_materials) к элементам курса(course_element)
  Как администратор системы
  Я хочу иметь возможность добавлять, редактировать и удалять материалы элементов курса
  @wip
  Структура сценария: Администратор заходит в элемент курс
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь переходит в курс <course>
    И пользователь переходит в элемент курса <course_element>
    То он видит кнопку "Добавить материал"
    Примеры:
      |course|course_element|
      |HTML  |Введение      |

  Сценарий: Администратор добавляет материал к элементу курса
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь находится на странице элемента курса "Начало работы"
    И пользователь нажимает на "Добавить материал"
    И его перекидывает на форму добавления материала
    И заполняет поле Заголовок материала "Тест материал"
    И заполняет поле "Содержимое"
    И пользователь нажимает на button "Добавить Материал"
    То отображается список с добавленным материалом "Тест материал"

  Сценарий: Администратор редактирует материал элемента курса
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И он находится на странице элемента курса "Введение"
    Если пользователь нажал на кнопку "Изменить" материала "Раздатка-1"
    То его перекидывает на форму изменения материала

  Сценарий: Администратор редактирует содержимое материала элемента курса
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь на странице редактирования материала "Введение"
    То он меняет содержимое поля "Заголовок материала" => с "Раздатка 1" на "Домашнее задание"
    И содержимое поля "Содержимое" => с "Содержимое раздатки 1" на "Измененное содержание раздатки"
    И нажимает кнопку "Обновить материал"
    И пользователь видит измененное имя материала в таблице

  Сценарий: Администратор удаляет материал курса
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    И пользователь находится на странице отображения материалов у элемента курса "Введение"
    Если пользователь удаляет материал с названием "Раздатка-1"
    То материал элемента курса "Раздатка-1" пропадет из списка