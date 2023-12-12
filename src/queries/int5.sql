.mode columns
.headers on
.nullvalue NULL

--Seleciona as 3 equipas com maior número de portugueses
select Equipa.idEquipa, Equipa.nomeEquipa, count(*) as quantidade
from Equipa
join Jogador
on Jogador.idEquipa=Equipa.idEquipa
where Jogador.nacionalidade = 'português'
group by 1
order by 3 desc
limit 3