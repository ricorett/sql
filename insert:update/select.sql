
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

