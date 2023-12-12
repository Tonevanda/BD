.mode columns
.headers on
.nullvalue NULL

--Seleciona todas as equipas que ganharam um jogo por uma diferença de 2 golos e o número de vezes que tal aconteceu
select Equipa.idEquipa, Equipa.nomeEquipa, count(*) as QUANTIDADE
from Equipa
join Jogo
on
case
    when Equipa.idEquipa = Jogo.idEquipaVisitada
    then Equipa.idEquipa = Jogo.idEquipaVisitada
    when Equipa.idEquipa = Jogo.idEquipaVisitante
    then Equipa.idEquipa = Jogo.idEquipaVisitante
end
where
case
    when Equipa.idEquipa = Jogo.idEquipaVisitada
    then Jogo.golosVisitada >= Jogo.golosVisitante + 2
    when Equipa.idEquipa = Jogo.idEquipaVisitante
    then Jogo.golosVisitante >= Jogo.golosVisitada + 2
end
group by 1
order by 1 asc