
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

