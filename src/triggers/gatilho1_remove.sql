Drop Trigger if exists atualizarJogador;
delete from EstatisticasJogador where idJogador=87;
update Jogador set nGolos=nGolos-10,tempoJogado=tempoJogado-15 where idJogador=87;
