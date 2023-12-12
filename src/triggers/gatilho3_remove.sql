Drop Trigger if exists updateGroupPoints;
delete from Jogo where idJogo = 41;
update Equipa set nPontos = nPontos - 3,
vitorias=vitorias-1, 
golosMarcados=golosMarcados-5,
jogosJogados=jogosJogados-1
where idEquipa = 4;

update Equipa set derrotas=derrotas-1,
golosSofridos=golosSofridos-5,
jogosJogados=jogosJogados-1
where idEquipa = 10;

