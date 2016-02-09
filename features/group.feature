#language:ru
Функция: Управление группой(group)
  Как администратор системы
  Я хочу иметь возможность просмотреть,создавать, редактировать и удалять группы
  Сценарий: Администратор заходит в курс
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь заходит в курс "HTML"
    То он видит список групп курса "HTML"

  Сценарий: Администратор создает группу
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь заходит в курс "HTML"
    И пользователь нажимает на "Создать группу"
    И вводит в название группы "HTML5"
    И пользователь нажимает на кнопку "Создать группу"
    То "HTML5" появляется в списке групп

  Сценарий: Администратор удаляет группу
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь заходит в курс "HTML"
    И пользователь удаляет группу с названием "Html1"
    То группа "Html1" пропадет из списка групп

  Сценарий: Администратор редактирyет группу
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь заходит в курс "HTML"
    И пользователь редактирует группу с названием "Html2" на "HTML3"
    То группа "Html2" пропадет из списка групп
    И "HTML3" появляется в списке групп

  Сценарий: Администратор просматривает группу
    Допустим залогинен пользователь под "a@a.a" с паролем "12345678"
    Если пользователь заходит в группу "Html1"
    То он видит список студентов группы "Html1"