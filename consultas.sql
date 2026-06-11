-- Agregação
select host_id, host_name, count(listing_id) as qtd_locacoes
from airbnb_host
natural join listing
group by host_id, host_name
order by qtd_locacoes asc;

-- Agregação +  Junção de 3 tabelas
select host_id, host_name, neighbourhood_name, count(listing_id) as qtd_locacoes_bairro
from airbnb_host
natural join listing
natural join neighbourhood
group by host_name, neighbourhood_name
order by qtd_locacoes_bairro asc;

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

USE airbnb_db;


-- Popularidade e engajamento por região - Junção Externa
SELECT ng.neighbourhood_group_name AS Regiao, COUNT(l.listing_id) AS Total_Imoveis,
ROUND(AVG(rs.reviews_per_month), 2) AS Media_Reviews_Por_Mes
FROM neighbourhood_group ng
LEFT JOIN neighbourhood n ON ng.neighbourhood_group_id = n.neighbourhood_group_id
LEFT JOIN listing l ON n.neighbourhood_id = l.neighbourhood_id
LEFT JOIN review_summary rs ON l.listing_id = rs.listing_id
GROUP BY ng.neighbourhood_group_id, ng.neighbourhood_group_name
ORDER BY Media_Reviews_Por_Mes DESC;
