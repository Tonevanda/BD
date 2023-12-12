.mode columns
.headers on
.nullvalue NULL

--Seleciona a equipa com o jogador mais velho
select Equipa.nomeEquipa, Jogador.nomeJogador, Jogador.idade, Jogador.posicao
from Jogador
join Equipa
on Equipa.idEquipa = Jogador.idEquipa
order by Jogador.idade DESC
limit 1