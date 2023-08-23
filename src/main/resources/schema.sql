CREATE TABLE IF NOT EXISTS genre
(
    id int generated by default as identity primary key,
    name_genre varchar(100)
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
    genre_id int REFERENCES genre(id) ON DELETE RESTRICT ,
    film_id int REFERENCES films(id) ON DELETE CASCADE,
    CONSTRAINT genre_film_pk PRIMARY KEY (genre_id, film_id)
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