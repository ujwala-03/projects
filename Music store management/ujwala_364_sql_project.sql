create database music_store;
use music_store; 
CREATE TABLE Genre (
	genre_id INT PRIMARY KEY auto_increment,
	name VARCHAR(120)
);

CREATE TABLE MediaType ( 
	media_type_id INT PRIMARY KEY auto_increment,
	name VARCHAR(120)
);


CREATE TABLE Employee (
	employee_id INT PRIMARY KEY auto_increment,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY auto_increment,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id) on update cascade
);

-- 4. Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY auto_increment,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY auto_increment,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id) on update cascade
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY auto_increment,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id) on update cascade,
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id) on update cascade,
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) on update cascade
);

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY auto_increment,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) on update cascade
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY auto_increment,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id) on update cascade,
	FOREIGN KEY (track_id) REFERENCES Track(track_id) on update cascade
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY auto_increment,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT auto_increment,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id) on update cascade,
	FOREIGN KEY (track_id) REFERENCES Track(track_id) on update cascade
); 

# 1. Who is the senior most employee based on job title? 
select * from Employee;
select first_name from Employee where title='General Manager';

# 2. Which countries have the most Invoices?
select * from invoice;
select billing_country, count(*) as country_count from invoice group by billing_country limit 1;

# 3. What are the top 3 values of total invoice?
select * from invoice order by total DESC limit 3;

#4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. 
#Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select billing_city, total from invoice order by total DESC limit 1;

#5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
select * from invoice;
select customer_id, total from invoice order by total desc limit 1;

#6. Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT
  ar.name_ AS ArtistName,
  COUNT(t.track_id) AS TrackCount
FROM artist AS ar
JOIN album AS al
  ON ar.artist_id = al.artist_id
JOIN track AS t
  ON al.album_id = t.album_id
JOIN Genre AS g
  ON t.genre_id = g.genre_id
WHERE g.name_ = 'Rock' GROUP BY ar.artist_id ORDER BY TrackCount DESC LIMIT 10;

#7. Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
select * from track;
SELECT name_, milliseconds FROM track WHERE milliseconds > (SELECT AVG(milliseconds) FROM Track)ORDER BY milliseconds DESC;
