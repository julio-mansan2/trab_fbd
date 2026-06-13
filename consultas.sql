-- Agregação
SELECT host_id, host_name, COUNT(listing_id) AS qtd_locacoes
FROM airbnb_host
NATURAL JOIN listing
GROUP BY host_id, host_name
ORDER BY qtd_locacoes ASC;

-- Agregação +  Junção de 3 tabelas
SELECT host_id, host_name, neighbourhood_name, COUNT(listing_id) AS qtd_locacoes_bairro
FROM airbnb_host
NATURAL JOIN listing
NATURAL JOIN neighbourhood
GROUP BY host_name, neighbourhood_name
ORDER BY qtd_locacoes_bairro ASC;

-- Bairros sem Quartos Compartilhados - Subconsulta (Not In)
SELECT n.neighbourhood_name AS Bairro
FROM neighbourhood n
WHERE n.neighbourhood_id NOT IN (
    SELECT DISTINCT l.neighbourhood_id
    FROM listing l
    JOIN room_type r ON l.room_type_id = r.room_type_id
    WHERE r.room_type = 'Shared room'
)
ORDER BY n.neighbourhood_name ASC;

-- Popularidade e engajamento por região - Junção Externa
SELECT ng.neighbourhood_group_name AS Regiao, COUNT(l.listing_id) AS Total_Imoveis,
ROUND(AVG(rs.reviews_per_month), 2) AS Media_Reviews_Por_Mes
FROM neighbourhood_group ng
LEFT JOIN neighbourhood n ON ng.neighbourhood_group_id = n.neighbourhood_group_id
LEFT JOIN listing l ON n.neighbourhood_id = l.neighbourhood_id
LEFT JOIN review_summary rs ON l.listing_id = rs.listing_id
GROUP BY ng.neighbourhood_group_id, ng.neighbourhood_group_name
ORDER BY Media_Reviews_Por_Mes DESC;

-- Junção externa + agregação
SELECT h.host_id, h.host_name, 
    COALESCE(SUM(rs.number_of_reviews), 0) AS total_avaliacoes_rede
FROM airbnb_host h
LEFT JOIN listing l ON h.host_id = l.host_id
LEFT JOIN review_summary rs ON l.listing_id = rs.listing_id
GROUP BY h.host_id, h.host_name
ORDER BY total_avaliacoes_rede DESC;

-- Subconsulta
SELECT l.listing_name, n.neighbourhood_name,l.availability_365
FROM listing l
JOIN neighbourhood n ON l.neighbourhood_id = n.neighbourhood_id
WHERE l.availability_365 = (
    SELECT MAX(availability_365) 
    FROM listing
)
ORDER BY l.listing_name ASC;

-- Operador de connjunto
SELECT listing_id, listing_name, minimum_nights, 'Estadia Curta' AS tipo_arrendamento
FROM listing
WHERE minimum_nights <= 3

UNION

SELECT listing_id, listing_name, minimum_nights, 'Estadia Longa' AS tipo_arrendamento
FROM listing
WHERE minimum_nights >= 30

ORDER BY minimum_nights ASC;

-- Subconsulta com tabela derivada
SELECT
    rt.room_type, 
    tabela_medias.media_noites
FROM room_type rt
JOIN (
    SELECT room_type_id, avg(minimum_nights) AS media_noites
    FROM listing
    GROUP BY room_type_id
) AS tabela_medias ON rt.room_type_id = tabela_medias.room_type_id
ORDER BY tabela_medias.media_noites DESC;
