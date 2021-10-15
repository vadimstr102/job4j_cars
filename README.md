[![Build Status](https://app.travis-ci.com/vadimstr102/job4j_cars.svg?branch=main)](https://app.travis-ci.com/vadimstr102/job4j_cars)

# Проект "Cars"

* [Описание](#описание)
* [Функционал](#функционал)
* [Технологии](#технологии)
* [Интерфейс](#интерфейс)
* [Автор](#автор)

## Описание

Проект представляет собой сайт для размещения объявлений по продаже автомобилей. Приложение построено на Java-сервлетах, с использованием JSP. Для
хранения данных применяется PostgreSQL и Hibernate.

## Функционал

* Регистрация и авторизация пользователя
* Добавление объявлений на главную страницу
* Загрузка фотографий
* Снятие автомобиля с продажи

## Технологии

* Java 14
* Servlets
* JSP
* JSTL
* PostgreSQL
* Hibernate
* Apache Tomcat Server
* Apache Commons FileUpload
* Travis CI
* Checkstyle
* Bootstrap

## Интерфейс

Форма авторизации.

![](screenshots/screenshot_1.png)

Форма регистрации.

![](screenshots/screenshot_2.png)

Форма создания объявления.

![](screenshots/screenshot_3.png)

Главная страница с созданным объявлением.

![](screenshots/screenshot_4.png)

Пользователь может менять статус своих объявлений.

![](screenshots/screenshot_5.png)

При нажатии на кнопку "Снять с продажи", объявление получает статус "Продано".

![](screenshots/screenshot_6.png)

При нажатии на кнопку "Выйти" происходит удаление пользователя из сессии. Неавторизованный пользователь может просматривать объявления.

![](screenshots/screenshot_7.png)

## Автор

Тимофеев Вадим Витальевич

Java разработчик

vadimstr102@gmail.com
