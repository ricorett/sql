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


INSERT INTO Artist (artist_name) VALUES ('Slipknot') ON CONFLICT (artist_name) DO NOTHING;
INSERT INTO Artist (artist_name) VALUES ('Metallica') ON CONFLICT (artist_name) DO NOTHING;
INSERT INTO Artist (artist_name) VALUES ('Omer Balik') ON CONFLICT (artist_name) DO NOTHING;
INSERT INTO Artist (artist_name) VALUES ('Becky Hills') ON CONFLICT (artist_name) DO NOTHING;


INSERT INTO Genre (genre_name) VALUES ('Heavy Metal') ON CONFLICT (genre_name) DO NOTHING;
INSERT INTO Genre (genre_name) VALUES ('Turkish Pop Music') ON CONFLICT (genre_name) DO NOTHING;
INSERT INTO Genre (genre_name) VALUES ('Dance Music') ON CONFLICT (genre_name) DO NOTHING;


INSERT INTO GenreArtist (genre_id, artist_id) 
SELECT g.id, a.id FROM Genre g, Artist a WHERE g.genre_name = 'Heavy Metal' AND a.artist_name = 'Slipknot'
ON CONFLICT (genre_id, artist_id) DO NOTHING;
INSERT INTO GenreArtist (genre_id, artist_id) 
SELECT g.id, a.id FROM Genre g, Artist a WHERE g.genre_name = 'Heavy Metal' AND a.artist_name = 'Metallica'
ON CONFLICT (genre_id, artist_id) DO NOTHING;
INSERT INTO GenreArtist (genre_id, artist_id) 
SELECT g.id, a.id FROM Genre g, Artist a WHERE g.genre_name = 'Turkish Pop Music' AND a.artist_name = 'Omer Balik'
ON CONFLICT (genre_id, artist_id) DO NOTHING;
INSERT INTO GenreArtist (genre_id, artist_id) 
SELECT g.id, a.id FROM Genre g, Artist a WHERE g.genre_name = 'Dance Music' AND a.artist_name = 'Becky Hills'
ON CONFLICT (genre_id, artist_id) DO NOTHING;


INSERT INTO Album (release_date, artist_id, album_name)
SELECT '2014-10-15', a.id, '.5: The Gray Chapter' FROM Artist a WHERE a.artist_name = 'Slipknot'
ON CONFLICT (album_name, artist_id) DO NOTHING;
INSERT INTO Album (release_date, artist_id, album_name)
SELECT '2020-08-28', a.id, 'S&M2' FROM Artist a WHERE a.artist_name = 'Metallica'
ON CONFLICT (album_name, artist_id) DO NOTHING;
INSERT INTO Album (release_date, artist_id, album_name)
SELECT '2019-12-19', a.id, 'The Arrival' FROM Artist a WHERE a.artist_name = 'Omer Balik'
ON CONFLICT (album_name, artist_id) DO NOTHING;
INSERT INTO Album (release_date, artist_id, album_name)
SELECT '2021-09-27', a.id, 'Only Honest on the Weekend' FROM Artist a WHERE a.artist_name = 'Becky Hills'
ON CONFLICT (album_name, artist_id) DO NOTHING;


INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'The Devil In I', '00:05:42', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Slipknot' AND al.album_name = '.5: The Gray Chapter'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'One — Live', '00:09:23', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Metallica' AND al.album_name = 'S&M2'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'All with love', '00:03:24', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Omer Balik' AND al.album_name = 'The Arrival'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'Remeber (with David Guetta)', '00:02:41', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Becky Hills' AND al.album_name = 'Only Honest on the Weekend'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'Last Time', '00:03:34', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Becky Hills' AND al.album_name = 'Only Honest on the Weekend'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'Custer', '00:04:41', a.id, al.id FROM Artist a, Album al WHERE a.artist_name = 'Slipknot' AND al.album_name = '.5: The Gray Chapter'
ON CONFLICT (track_name, album_id) DO NOTHING;
INSERT INTO Track (track_name, duration, artist_id, album_id)
SELECT 'My Heart Goes (La Di Da)', '00:02:28', a.id, al.id FROM artist a, album al WHERE a.artist_name = 'Becky Hill' AND al.album_name  = 'Only Honest on the Weekend';

INSERT INTO ArtistAlbum (album_id, artist_id) 
SELECT al.id, a.id FROM Album al, Artist a WHERE al.album_name = '.5: The Gray Chapter' AND a.artist_name = 'Slipknot'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO ArtistAlbum (album_id, artist_id) 
SELECT al.id, a.id FROM Album al, Artist a WHERE al.album_name = 'S&M2' AND a.artist_name = 'Metallica'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO ArtistAlbum (album_id, artist_id) 
SELECT al.id, a.id FROM Album al, Artist a WHERE al.album_name = 'The Arrival' AND a.artist_name = 'Omer Balik'
ON CONFLICT (album_id, artist_id) DO NOTHING;
INSERT INTO ArtistAlbum (album_id, artist_id) 
SELECT al.id, a.id FROM Album al, Artist a WHERE al.album_name = 'Only Honest on the Weekend' AND a.artist_name = 'Becky Hills'
ON CONFLICT (album_id, artist_id) DO NOTHING;


INSERT INTO Collection (collection_name, release_date) 
VALUES ('Best of Heavy Metal', '2022-01-01') ON CONFLICT (collection_name) DO NOTHING;
INSERT INTO Collection (collection_name, release_date) 
VALUES ('Top Turkish Pop', '2022-02-01') ON CONFLICT (collection_name) DO NOTHING;
INSERT INTO Collection (collection_name, release_date) 
VALUES ('Dance Hits', '2022-03-01') ON CONFLICT (collection_name) DO NOTHING;
INSERT INTO Collection (collection_name, release_date) 
VALUES ('Mixed Playlist', '2022-04-01') ON CONFLICT (collection_name) DO NOTHING;


INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'The Devil In I' AND c.collection_name = 'Best of Heavy Metal'
ON CONFLICT (track_id, collection_id) DO NOTHING;
INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'Custer' AND c.collection_name = 'Best of Heavy Metal'
ON CONFLICT (track_id, collection_id) DO NOTHING;
INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'One — Live' AND c.collection_name = 'Best of Heavy Metal'
ON CONFLICT (track_id, collection_id) DO NOTHING;
INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'All with love' AND c.collection_name = 'Top Turkish Pop'
ON CONFLICT (track_id, collection_id) DO NOTHING;
INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'Remeber (with David Guetta)' AND c.collection_name = 'Dance Hits'
ON CONFLICT (track_id, collection_id) DO NOTHING;
INSERT INTO TrackCollection (track_id, collection_id) 
SELECT t.id, c.id FROM Track t, Collection c WHERE t.track_name = 'My Heart Goes (La Di Da)' AND c.collection_name = 'Dance Hits'
ON CONFLICT (track_id, collection_id) DO NOTHING;

UPDATE public.collection
SET collection_name='Best of Heavy Metal', release_date='2020-01-01'
WHERE id=1;
UPDATE public.collection
SET collection_name='Top Turkish Pop', release_date='2018-12-15'
WHERE id=2;
UPDATE public.collection
SET collection_name='Dance Hits', release_date='2019-03-13'
WHERE id=3;
UPDATE public.collection
SET collection_name='Mixed Playlist', release_date='2024-07-07'
WHERE id=4;

SELECT track_name, duration 
FROM Track 
ORDER BY duration DESC 
LIMIT 1;

SELECT track_name 
FROM Track 
WHERE duration >= '00:03:30';

SELECT collection_name 
FROM Collection 
WHERE release_date BETWEEN '2018-01-01' AND '2020-12-31';

SELECT artist_name 
FROM Artist 
WHERE artist_name NOT LIKE '% %';

SELECT track_name 
FROM Track 
WHERE track_name ILIKE '%мой%' OR track_name ILIKE '%my%';

SELECT g.genre_name, COUNT(ga.artist_id) AS artist_count
FROM Genre g
JOIN GenreArtist ga ON g.id = ga.genre_id
GROUP BY g.genre_name;

SELECT COUNT(t.id) AS track_count
FROM Track t
JOIN Album a ON t.album_id = a.id
WHERE a.release_date BETWEEN '2019-01-01' AND '2020-12-31';

SELECT a.album_name, AVG(t.duration) AS avg_duration
FROM Track t
JOIN Album a ON t.album_id = a.id
GROUP BY a.album_name;

SELECT a.artist_name 
FROM Artist a
WHERE a.id NOT IN (
    SELECT artist_id 
    FROM Album 
    WHERE release_date BETWEEN '2020-01-01' AND '2020-12-31'
);

SELECT DISTINCT c.collection_name
FROM Collection c
JOIN TrackCollection tc ON c.id = tc.collection_id
JOIN Track t ON tc.track_id = t.id
JOIN Artist a ON t.artist_id = a.id
WHERE a.artist_name = 'Slipknot';

