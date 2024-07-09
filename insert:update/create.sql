--CREATE DATABASE UPDATE1;
--CREATE SCHEMA schema_sql;

CREATE TABLE IF NOT EXISTS Artist (
    id SERIAL PRIMARY KEY,
    artist_name VARCHAR(60) UNIQUE
);

CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Album (
    id SERIAL PRIMARY KEY,
    album_name VARCHAR(150) NOT NULL,
    release_date DATE,
    artist_id INTEGER REFERENCES Artist(id)
);

CREATE TABLE IF NOT EXISTS GenreArtist (
    genre_id INTEGER REFERENCES Genre(id),
    artist_id INTEGER REFERENCES Artist(id),
    PRIMARY KEY (genre_id, artist_id)
);


CREATE TABLE IF NOT EXISTS ArtistAlbum (
    album_id INTEGER REFERENCES Album(id),
    artist_id INTEGER REFERENCES Artist(id),
    PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS Track (
    id SERIAL PRIMARY KEY,
    track_name VARCHAR(100) NOT NULL,
    duration TIME,
    artist_id INTEGER REFERENCES Artist(id),
    album_id INTEGER REFERENCES Album(id),
    UNIQUE (track_name, album_id)
);

CREATE TABLE IF NOT EXISTS Collection (
    id SERIAL PRIMARY KEY,
    collection_name VARCHAR(100) NOT NULL,
    release_date DATE
);

CREATE TABLE IF NOT EXISTS TrackCollection (
    track_id INTEGER REFERENCES Track(id),
    collection_id INTEGER REFERENCES Collection(id),
    PRIMARY KEY (track_id, collection_id)
);

