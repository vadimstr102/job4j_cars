create table users
(
    id       serial primary key,
    name     varchar(100) not null,
    phone    varchar(50)  not null,
    email    varchar(50)  not null unique,
    password varchar(20)  not null
);

create table brands
(
    id   serial primary key,
    name varchar(50) not null unique
);

create table colors
(
    id   serial primary key,
    name varchar(50) not null unique
);

create table bodies
(
    id   serial primary key,
    name varchar(50) not null unique
);

create table cars
(
    id       serial primary key,
    year     int                        not null,
    price    int                        not null,
    model    varchar(50)                not null,
    brand_id int references brands (id) not null,
    color_id int references colors (id) not null,
    body_id  int references bodies (id) not null
);

create table posts
(
    id          serial primary key,
    description varchar(2000)             not null,
    created     timestamp                 not null,
    is_sold     boolean                   not null,
    user_id     int references users (id) not null,
    car_id      int references cars (id)  not null
);

create table photos
(
    id      serial primary key,
    name    varchar(50) not null,
    post_id int references posts (id)
);

insert into bodies (name)
values ('Седан'),
       ('Хетчбэк'),
       ('Универсал'),
       ('Кабриолет'),
       ('Купе'),
       ('Кроссовер'),
       ('Внедорожник'),
       ('Фургон'),
       ('Минивэн'),
       ('Пикап'),
       ('Микроавтобус');

insert into brands (name)
values ('Audi'),
       ('BMW'),
       ('Chevrolet'),
       ('Citroen'),
       ('Ford'),
       ('Honda'),
       ('Hyundai'),
       ('Kia'),
       ('Land Rover'),
       ('Lexus'),
       ('Mazda'),
       ('Mercedes-Benz'),
       ('Mitsubishi'),
       ('Nissan'),
       ('Opel'),
       ('Peugeot'),
       ('Renault'),
       ('Skoda'),
       ('Subaru'),
       ('Suzuki'),
       ('Toyota'),
       ('Volvo'),
       ('Lada'),
       ('GAZ'),
       ('UAZ'),
       ('ZAZ'),
       ('Other');

insert into colors (name)
values ('Белый'),
       ('Бежевый'),
       ('Серебристый'),
       ('Серый'),
       ('Чёрный'),
       ('Коричневый'),
       ('Красный'),
       ('Оранжевый'),
       ('Жёлтый'),
       ('Зелёный'),
       ('Голубой'),
       ('Синий'),
       ('Фиолетовый'),
       ('Розовый');
