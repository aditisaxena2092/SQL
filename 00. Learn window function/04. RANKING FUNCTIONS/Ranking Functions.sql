USE extras;
CREATE TABLE games(
					id integer,
					name text,
					platform text,
					genre text,
					editor_rating integer,
					size integer,
					released text,
					updated text);
UPDATE games SET released = str_to_date(released, '%d-%m-%Y');
UPDATE games SET updated = str_to_date(updated, '%d-%m-%Y');
CREATE TABLE purchase_games(
					id integer,
					price float,
					date text);
UPDATE purchase_games SET date = str_to_date(date, '%d-%m-%Y');

#01. Return the rank of each row when sort by the column editor_rating
SELECT *,
RANK() OVER(ORDER BY editor_rating) AS Rank_
FROM games;

#02. Same query with dense rank
SELECT *,
DENSE_RANK() OVER(ORDER BY editor_rating) AS Rank_
FROM games;

#03. same query with row number
SELECT *,
ROW_NUMBER() OVER(ORDER BY editor_rating) AS Rank_
FROM games;

#04. For each game, show its name, genre and date of release. 
#In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
SELECT *,
RANK() OVER(ORDER BY editor_rating) AS 'Rank',
DENSE_RANK() OVER(ORDER BY editor_rating) AS 'Dense_Rank',
ROW_NUMBER() OVER(ORDER BY editor_rating) AS 'Row_Number'
FROM games;

#05. Order by multiple columns
SELECT *,
RANK() OVER(ORDER BY released DESC, size ASC) AS new_game
FROM games;

#06.Games which were both recently released and recently updated
SELECT *
,
ROW_NUMBER() OVER(ORDER BY released DESC, updated DESC) AS recents
FROM games;

#07.
SELECT name,size,
  RANK() OVER (ORDER BY editor_rating) AS Rank_
FROM games
ORDER BY size DESC; 

#08. NTILE
SELECT *,
NTILE(3) OVER(ORDER BY editor_rating DESC) AS groups
FROM games;

#09.
WITH ranking as(
		SELECT *,
		RANK() OVER(ORDER BY editor_rating) AS Rank_,
		DENSE_RANK() OVER(ORDER BY editor_rating) AS 'Dense_Rank',
		ROW_NUMBER() OVER(ORDER BY editor_rating) AS 'Row_Number'
		FROM games)
SELECT * FROM ranking WHERE Rank_ = 4;

#10.1  Name, genre and size of the smallest game in our studio.
WITH game_size as(
		SELECT name,genre,size,
		RANK() OVER(ORDER BY size) AS sorted_by_size
		FROM games)
SELECT name,genre,size FROM game_size WHERE sorted_by_size=1;

#10.2
SELECT name,genre,size
 FROM games
 WHERE size=(SELECT MIN(size) FROM games);

#11. Show the name, platform and update date of the second most recently updated game
WITH recently_updated as (
		SELECT *,
		DENSE_RANK() OVER( ORDER BY updated DESC) AS recently_updated
		FROM games)
SELECT name, platform, updated FROM recently_updated WHERE recently_updated=2;


