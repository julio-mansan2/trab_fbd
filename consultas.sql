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
select h.host_id, h.host_name, 
    coalesce(SUM(rs.number_of_reviews), 0) as total_avaliacoes_rede
from airbnb_host h
left join listing l on h.host_id = l.host_id
left join review_summary rs on l.listing_id = rs.listing_id
group by h.host_id, h.host_name
order by total_avaliacoes_rede desc;

-- Subconsulta
select l.listing_name, n.neighbourhood_name,l.availability_365
from listing l
join neighbourhood n on l.neighbourhood_id = n.neighbourhood_id
where l.availability_365 = (
    select MAX(availability_365) 
    from listing
)
order by l.listing_name asc;

-- Operador de connjunto
select listing_id, listing_name, minimum_nights, 'Estadia Curta' as tipo_arrendamento
from listing
where minimum_nights <= 3

union

select listing_id, listing_name, minimum_nights, 'Estadia Longa' as tipo_arrendamento
from listing
where minimum_nights >= 30

order by minimum_nights asc;

-- Subconsulta com tabela derivada
select 
    rt.room_type, 
    tabela_medias.media_noites
from room_type rt
join (
    select room_type_id, avg(minimum_nights) as media_noites
    from listing
    group by room_type_id
) as tabela_medias on rt.room_type_id = tabela_medias.room_type_id
order by tabela_medias.media_noites desc;
