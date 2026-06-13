-- Extração de dados
--Observação: se necessário, iniciar o mysql com: mysql --local-infile=1 -u user -p
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE '/home/joaopedro/Downloads/listings (1).csv' -- essa linha varia
INTO TABLE airbnb_desnormalizado 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

-- Conversão para tabelas normalizadas
-- airbnb_host
INSERT INTO airbnb_host (
    host_id,
    host_profile_id,
    host_name
    ) SELECT DISTINCT
          host_id ,
          host_profile_id,
          host_name
      FROM airbnb_desnormalizado;

-- neighbourhood_group
INSERT INTO neighbourhood_group (
        neighbourhood_group_name
    ) SELECT DISTINCT
          neighbourhood_group
      FROM airbnb_desnormalizado;

-- room_type
INSERT INTO room_type (
        room_type
    ) SELECT DISTINCT
          room_type
      FROM airbnb_desnormalizado;

-- neighbourhood
INSERT INTO neighbourhood (
        neighbourhood_name,
        neighbourhood_group_id
    ) SELECT DISTINCT 
          ad.neighbourhood,
          ng.neighbourhood_group_id
      FROM airbnb_desnormalizado ad 
      JOIN neighbourhood_group ng ON ng.neighbourhood_group_name = ad.neighbourhood_group;

-- listing
INSERT INTO listing (
        listing_id,
        listing_name,
        price,
        minimum_nights,
        availability_365,
        license,
        latitude,
        longitude,
        neighbourhood_id,
        room_type_id,
        host_id
    ) SELECT DISTINCT
          ad.id,
          ad.name,
          ad.price,
          ad.minimum_nights,
          ad.availability_365,
          ad.license,
          ad.latitude,
          ad.longitude,
          n.neighbourhood_id,
          r.room_type_id,
          ad.host_id
      FROM airbnb_desnormalizado ad
      JOIN neighbourhood n ON n.neighbourhood_name = ad.neighbourhood
      JOIN room_type r ON r.room_type = ad.room_type;

-- review_summary
INSERT INTO review_summary (
        listing_id,
        number_of_reviews,
        last_review,
        reviews_per_month,
        number_of_reviews_ltm
    ) SELECT DISTINCT
          ad.id,
          ad.number_of_reviews,
          NULLIF(ad.last_review, 0000-00-00),
          ad.reviews_per_month,
          ad.number_of_reviews_ltm
      FROM airbnb_desnormalizado ad;
