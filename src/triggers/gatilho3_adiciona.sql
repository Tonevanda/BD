--Atualiza o número de pontos da ambas as equipas após um jogo durante a fase de groupos
CREATE TRIGGER updateGroupPoints
AFTER INSERT ON Jogo
FOR EACH ROW
WHEN new.eliminatoria = 'Fase-de-grupos'
BEGIN
    UPDATE Equipa
    SET nPontos = (CASE
                    WHEN (new.golosVisitada > new.golosVisitante) THEN nPontos+3
                    WHEN (new.golosVisitada = new.golosVisitante) THEN nPontos+1
                    WHEN (new.golosVisitada < new.golosVisitante) THEN nPontos+0
                  END),
    vitorias=(CASE
                  WHEN (new.golosVisitada > new.golosVisitante) THEN vitorias+1
                  ELSE vitorias
              END),
    empates=(CASE
                  WHEN (new.golosVisitada = new.golosVisitante) THEN empates+1
                  ELSE empates
              END),
    derrotas=(CASE
                  WHEN (new.golosVisitada < new.golosVisitante) THEN derrotas+1
                  ELSE derrotas
              END),
    golosMarcados=golosMarcados+new.golosVisitada,
    golosSofridos=golosSofridos+new.golosVisitante,
    jogosJogados=jogosJogados+1
    WHERE idEquipa=new.idEquipaVisitada;
    
    UPDATE Equipa
    SET nPontos = CASE
                    WHEN (new.golosVisitada > new.golosVisitante) THEN nPontos+0
                    WHEN (new.golosVisitada = new.golosVisitante) THEN nPontos+1
                    WHEN (new.golosVisitada < new.golosVisitante) THEN nPontos+3
                  END,
    vitorias=(CASE
                  WHEN (new.golosVisitada < new.golosVisitante) THEN vitorias+1
                  ELSE vitorias
              END),
    empates=(CASE
                  WHEN (new.golosVisitada = new.golosVisitante) THEN empates+1
                  ELSE empates
              END),
    derrotas=(CASE
                  WHEN (new.golosVisitada > new.golosVisitante) THEN derrotas+1
                  ELSE derrotas
              END),
    golosMarcados=golosMarcados+new.golosVisitante,
    golosSofridos=golosSofridos+new.golosVisitada,
    jogosJogados=jogosJogados+1
    WHERE idEquipa=new.idEquipaVisitante;
END;

