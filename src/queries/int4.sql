.mode columns
.headers on
.nullvalue NULL

--Seleciona o melhor marcador de cada equipa
select j1.idJogador, j1.nomeJogador, j1.nGolos, Equipa.nomeEquipa
from Jogador j1
join Equipa
on j1.idEquipa = Equipa.idEquipa
where j1.nGolos = 
(select max(nGolos)
from Jogador j2
where j2.idEquipa = j1.idEquipa
group by idEquipa)
order by 3 DESC