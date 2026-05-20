create database airbnb_db;

create table airbnb_desnormalizado (
	id bigint,
	location_name text,
    host_id bigint,
    host_profile_id bigint,
    host_name text,
    neighbourhood_group text,
    neighbourhood text,
    latitude double,
    longitude double,
    room_type text,
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

drop table location;

use airbnb_db