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

CREATE TABLE airbnb_host (
    host_id BIGINT PRIMARY KEY,
    host_profile_id BIGINT,
    host_name VARCHAR(255)
);

CREATE TABLE neighbourhood_group (
    neighbourhood_group_name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE neighbourhood (
    neighbourhood_name VARCHAR(255) PRIMARY KEY,
    neighbourhood_group VARCHAR(255),

    FOREIGN KEY(neighbourhood_group)
        REFERENCES neighbourhood_group(neighbourhood_group_name)
);

CREATE TABLE room_type (
    room_type VARCHAR(100) PRIMARY KEY
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

    neighbourhood_name VARCHAR(255),
    room_type VARCHAR(100),
    host_id BIGINT,

    FOREIGN KEY(neighbourhood_name)
        REFERENCES neighbourhood(neighbourhood_name),

    FOREIGN KEY(room_type)
        REFERENCES room_type(room_type),

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