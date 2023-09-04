DROP TABLE IF EXISTS users, films, likes, friendship, genre, genre_films, rating CASCADE;

CREATE TABLE IF NOT EXISTS genre
(
    id int generated by default as identity primary key,
    name_genre varchar(100)
);

CREATE TABLE IF NOT EXISTS director
(
    id int generated by default as identity primary key,
    name_director varchar(200)
);

CREATE TABLE IF NOT EXISTS rating
(
    mpa_id int generated by default as identity primary key,
    name_rating varchar(100)
);

CREATE TABLE IF NOT EXISTS users
(
    id int generated by default as identity primary key,
    name varchar(100),
    login varchar(100),
    email varchar(100),
    birthday timestamp
);
create unique index if not exists USER_EMAIL_UINDEX on USERS (email);
create unique index if not exists USER_LOGIN_UINDEX on USERS (login);

CREATE TABLE IF NOT EXISTS films
(
    id int generated by default as identity primary key,
    rating_id   int REFERENCES rating(mpa_id) ON DELETE RESTRICT,
    name varchar(100),
    description varchar(200),
    release_date timestamp,
    duration int
);

CREATE TABLE IF NOT EXISTS genre_films
(
    genre_id int REFERENCES genre(id) ON DELETE CASCADE,
    film_id int REFERENCES films(id) ON DELETE CASCADE,
    CONSTRAINT genre_film_pk PRIMARY KEY (genre_id, film_id)
);

CREATE TABLE IF NOT EXISTS director_films
(
    director_id int REFERENCES director(id) ON DELETE CASCADE,
    film_id int REFERENCES films(id) ON DELETE CASCADE,
    CONSTRAINT director_film_pk PRIMARY KEY (director_id, film_id)
);

CREATE TABLE IF NOT EXISTS friendship
(
    user_id int REFERENCES users(id) ON DELETE CASCADE,
    friend_id int REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT pk_user_id_friend_id PRIMARY KEY (user_id, friend_id)
);

CREATE TABLE IF NOT EXISTS likes
(
    film_id int REFERENCES films(id) ON DELETE CASCADE,
    user_id int REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT pk_film_id_user_id PRIMARY KEY (film_id, user_id)
);

CREATE TABLE IF NOT EXISTS reviews
(
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content VARCHAR(400) NOT NULL,
    is_positive BOOLEAN NOT NULL,
    user_id INTEGER NOT NULL,
    film_id INTEGER NOT NULL,
    CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT fk_film_id FOREIGN KEY(film_id) REFERENCES films(id)
);

CREATE TABLE IF NOT EXISTS like_review
(
    review_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    is_positive BOOLEAN NOT NULL
);