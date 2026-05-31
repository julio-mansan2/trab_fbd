create database airbnb_db;

-- Tabela Desnormalizada

create table airbnb_desnormalizado (
	id bigint primary key,
	name text,
    host_id bigint,
    host_profile_id bigint,
    host_name varchar(255),
    neighbourhood_group varchar(255),
    neighbourhood varchar(255),
    latitude double,
    longitude double,
    room_type varchar(100),
    price double,
    minimum_nights int,
    number_of_reviews int,
    last_review date,
    reviews_per_month double,
    calculated_host_listings_count int,
    availability_365 int,
    number_of_reviews_ltm int,
    license text
);

drop table airbnb_desnormalizado;

-- Tabelas Normalizadas (talvez)

CREATE TABLE listing (
    listing_id BIGINT PRIMARY KEY,
    listing_name TEXT,

    price DOUBLE,
    minimum_nights INT,
    availability_365 INT,
    license TEXT,
    room_type VARCHAR(100),

    latitude DOUBLE,
    longitude DOUBLE,

    neighbourhood_id BIGINT,
    host_id BIGINT,

    FOREIGN KEY(neighbourhood_id)
        REFERENCES neighbourhood(neighbourhood_id),

    FOREIGN KEY(host_id)
        REFERENCES airbnb_host(host_id)
);

CREATE TABLE airbnb_host (
    host_id BIGINT PRIMARY KEY,
    host_profile_id BIGINT,
    host_name VARCHAR(255),
    calculated_host_listings_count INT
);

CREATE TABLE neighbourhood_group (
    neighbourhood_group_id BIGINT PRIMARY KEY,
    neighbourhood_group_name VARCHAR(255)
);

CREATE TABLE neighbourhood (
    neighbourhood_id BIGINT PRIMARY KEY,
    neighbourhood_name VARCHAR(255),
    neighbourhood_group_id BIGINT,

    FOREIGN KEY(neighbourhood_group_id)
        REFERENCES neighbourhood_group(neighbourhood_group_id)
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

use airbnb_db
