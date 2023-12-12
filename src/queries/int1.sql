.mode columns
.headers on
.nullvalue NULL

--Seleciona todos os treinadores e organiza-os por número de vitórias descendentemente, por empates descendentemente caso tenha o mesmo numero de vitorias e por derrotas
--ascendentemente caso tenha também o mesmo número de empates
select Treinador.nomeTreinador, equipa.vitorias, equipa.empates, equipa.derrotas
from Treinador
join Equipa
on Equipa.idTreinador = Treinador.idTreinador
order by 2 desc, equipa.empates desc, equipa.derrotas asc