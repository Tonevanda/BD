.mode columns
.headers on
.nullvalue NULL

--Seleciona todos os jogadores que marcaram pelo menos 5 golos em fases eliminatórias em jogos arbitrados por um árbitro de nível igual ou superior a 5
select nomeJogador, totalGolos, nomeEquipa
from (select Jogador.nomeJogador, sum(EstatisticasJogador.golosMarcados) as totalGolos, Equipa.nomeEquipa
from Jogador
join EstatisticasJogador
on Jogador.idJogador = EstatisticasJogador.idJogador
join Equipa
on Jogador.idEquipa = Equipa.idEquipa
join Jogo
on
case
    when Jogador.idEquipa = Jogo.idEquipaVisitada
    then Jogador.idEquipa = Jogo.idEquipaVisitada
    when Jogador.idEquipa = Jogo.idEquipaVisitante
    then Jogador.idEquipa = Jogo.idEquipaVisitante
end
join Arbitro
on Jogo.idArbitro = Arbitro.idArbitro
where ((Arbitro.nivel >= 5)
AND (Jogo.eliminatoria in ('Oitavos-de-final', 'Quartos-de-final', 'Semi-final', 'Final'))
AND (EstatisticasJogador.golosMarcados >= 1))
group by jogador.idJogador)
where totalGolos >= 5
order by totalGolos desc