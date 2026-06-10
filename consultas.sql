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