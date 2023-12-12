.mode columns
.headers on
.nullvalue NULL

--Seleciona todos os jogadores que marcaram todos os golos da sua equipa num dado jogo e o número de vezes que tal aconteceu
select Jogador.nomeJogador, EstatisticasJogador.golosMarcados, count(*) as Ocorrencias
from Jogador
join EstatisticasJogador
on jogador.idJogador = EstatisticasJogador.idJogador
join Jogo
on
case
    when Jogador.idEquipa = Jogo.idEquipaVisitada
    then Jogador.idEquipa = Jogo.idEquipaVisitada
    when Jogador.idEquipa = Jogo.idEquipaVisitante
    then Jogador.idEquipa = Jogo.idEquipaVisitante
end
where
case
    when Jogador.idEquipa = Jogo.idEquipaVisitada
    then EstatisticasJogador.GolosMarcados = Jogo.golosVisitada
    when Jogador.idEquipa = Jogo.idEquipaVisitante
    then EstatisticasJogador.GolosMarcados = Jogo.golosVisitante
end
group by Jogador.idJogador
order by 3 DESC