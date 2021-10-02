create table users
(
    id       serial primary key,
    name     varchar(100) not null,
    phone    varchar(50)  not null,
    email    varchar(50)  not null unique,
    password varchar(20)  not null
);

create table cars
(
    id    serial primary key,
    brand varchar(50) not null,
    model varchar(50) not null,
    body  varchar(50) not null
);

create table posts
(
    id          serial primary key,
    description varchar(2000)             not null,
    created     timestamp                 not null,
    is_sold      boolean                   not null,
    user_id     int references users (id) not null,
    car_id      int references cars (id)  not null
);

create table photos
(
    id      serial primary key,
    name    varchar(50)               not null,
    post_id int references posts (id) not null
);
