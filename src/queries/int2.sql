.mode columns
.headers on
.nullvalue NULL

--Seleciona todos os árbitros que oficializaram jogos em estádios com capacidade maior do que 50000 e que resultaram num empate
select Arbitro.idArbitro, Arbitro.nomeArbitro, Estadio.nomeEstadio, Estadio.capacidade, eq1.nomeEquipa as Casa, eq2.nomeEquipa as Fora, Jogo.golosVisitada as GolosCasa, Jogo.golosVisitante as GolosFora
from Arbitro
join Jogo
on Jogo.idArbitro = Arbitro.idArbitro
join Estadio
on Jogo.idEstadio = Estadio.idEstadio
join Equipa eq1
on Jogo.idEquipaVisitada = eq1.idEquipa
join Equipa eq2
on Jogo.idEquipaVisitante = eq2.idEquipa
where ((Estadio.capacidade >= 50000)
AND
(Jogo.golosVisitada = Jogo.golosVisitante))
order by 1 asc