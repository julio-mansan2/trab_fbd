create database airbnb_db;

-- Tabela Desnormalizada
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'E:\listings (1).csv' 
INTO TABLE airbnb_desnormalizado 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select license 
from airbnb_desnormalizado;

create table airbnb_desnormalizado (
	id varchar(255) primary key,
	name varchar(255),
    host_id varchar(255),
    host_profile_id varchar(255),
    host_name varchar(255),
    neighbourhood_group varchar(255),
    neighbourhood varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    room_type varchar(100),
    price varchar(255),
    minimum_nights varchar(255),
    number_of_reviews varchar(255),
    last_review varchar(255),
    reviews_per_month varchar(255),
    calculated_host_listings_count varchar(255),
    availability_365 varchar(255),
    number_of_reviews_ltm varchar(255),
    license varchar(255)
);


drop table airbnb_desnormalizado;

-- Tabelas Normalizadas (talvez)

CREATE TABLE airbnb_host (
    host_id BIGINT PRIMARY KEY,
    host_profile_id BIGINT,
    host_name VARCHAR(255)
);

CREATE TABLE neighbourhood_group (
	neighbourhood_group_id INT PRIMARY KEY,
    neighbourhood_group_name VARCHAR(255)
);

CREATE TABLE neighbourhood (
	neighbourhood_id INT PRIMARY KEY,
    neighbourhood_name VARCHAR(255),
    neighbourhood_group_id INT,

    FOREIGN KEY(neighbourhood_group_id)
        REFERENCES neighbourhood_group(neighbourhood_group_id)
);

CREATE TABLE room_type (
	room_type_id INT PRIMARY KEY,
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

create table review_summary (
	listing_id bigint primary key,
    number_of_reviews int,
    last_review date,
    reviews_per_month double,
    number_of_reviews_ltm int,
    
    foreign key(listing_id)
		references listing(listing_id)
);

use airbnb_db