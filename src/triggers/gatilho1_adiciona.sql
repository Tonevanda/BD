--Após se atualizar a estatistica de um jogador num jogo em particular (EstatisticasJogador) aplicar as mudanças apropriadas em Jogador
CREATE TRIGGER atualizarJogador
AFTER insert on EstatisticasJogador 
For each row
Begin
update Jogador set nGolos=nGolos+new.golosMarcados,tempoJogado=tempoJogado+new.tempoJogado
where Jogador.idJogador=new.idJogador;
End;
