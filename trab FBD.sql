CREATE DATABASE airbnb_db;

-- Tabela Desnormalizada
CREATE TABLE airbnb_desnormalizado (
	  id BIGINT PRIMARY KEY,
	  name TEXT,
    host_id BIGINT,
    host_profile_id BIGINT,
    host_name VARCHAR(255),
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude DOUBLE,
    longitude DOUBLE,
    room_type VARCHAR(100),
    price DOUBLE,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month INT,
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    license TEXT
);

-- Tabelas Normalizadas
CREATE TABLE airbnb_host (
    host_id BIGINT PRIMARY KEY,
    host_profile_id BIGINT,
    host_name VARCHAR(255)
);

CREATE TABLE neighbourhood_group (
	  neighbourhood_group_id INT AUTO_INCREMENT PRIMARY KEY,
    neighbourhood_group_name VARCHAR(255)
);

CREATE TABLE neighbourhood (
	  neighbourhood_id INT AUTO_INCREMENT PRIMARY KEY,
    neighbourhood_name VARCHAR(255),
    neighbourhood_group_id INT,

    FOREIGN KEY(neighbourhood_group_id)
        REFERENCES neighbourhood_group(neighbourhood_group_id)
);

CREATE TABLE room_type (
  	room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type VARCHAR(100)
);

CREATE TABLE listing (
    listing_id BIGINT PRIMARY KEY,
    listing_name TEXT,

    price DOUBLE,
    minimum_nights INT,
    availability_365 INT,
    license TEXT,

    latitude DOUBLE,
    longitude DOUBLE,

    neighbourhood_id INT,
    room_type_id INT,
    host_id BIGINT,

    FOREIGN KEY(neighbourhood_id)
        REFERENCES neighbourhood(neighbourhood_id),

    FOREIGN KEY(room_type_id)
        REFERENCES room_type(room_type_id),

    FOREIGN KEY(host_id)
        REFERENCES airbnb_host(host_id)
);

CREATE TABLE review_summary (
	  listing_id BIGINT PRIMARY KEY,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month DOUBLE,
    number_of_reviews_ltm INT,
    
    FOREIGN KEY(listing_id)
		    REFERENCES listing(listing_id)
);
