.mode columns
.headers on
.nullvalue NULL

--Seleciona os dois primeiros classificados de cada grupo
select Equipa.idGrupo, Equipa.nomeEquipa, Equipa.classificacao
from Equipa
where (Equipa.classificacao = '1' OR Equipa.classificacao = '2')
order by 1 asc, 3 ASC