.mode columns
.headers ON
PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS EstatisticasJogador;
DROP TABLE IF EXISTS Jogo;
DROP TABLE IF EXISTS Estadio;
DROP TABLE IF EXISTS Arbitro;
DROP TABLE IF EXISTS Jogador;
DROP TABLE IF EXISTS Equipa;
DROP TABLE IF EXISTS Treinador;
DROP TABLE IF EXISTS Estados;
DROP TABLE IF EXISTS Grupo;



CREATE TABLE Grupo(
    idGrupo VARCHAR(1) PRIMARY KEY,

    CONSTRAINT check_idGrupo CHECK (idGrupo == 'A' OR idGrupo == 'B' OR idGrupo == 'C' OR idGrupo == 'D' OR idGrupo == 'E' OR idGrupo == 'F' OR idGrupo == 'G' OR idGrupo == 'H')
);

CREATE TABLE Estados(
    tipoEstado VARCHAR(255) PRIMARY KEY,

    CONSTRAINT check_tipoEstado CHECK (tipoEstado == 'Pre-eliminatorias' OR tipoEstado == 'Fase-de-grupos' OR tipoEstado == 'Oitavos-de-final' OR tipoEstado == 'Quartos-de-final' OR tipoEstado == 'Semi-final' OR tipoEstado == 'Final')
);

CREATE TABLE Treinador(
    idTreinador INT PRIMARY KEY,
    nomeTreinador VARCHAR(255) NOT NULL,
    estiloDeJogo VARCHAR(255),

    CONSTRAINT check_estiloDeJogo CHECK (estiloDeJogo == 'Tiki-taka' OR estiloDeJogo == 'Park the bus' OR estiloDeJogo == 'Long ball' OR estiloDeJogo == 'Counter-attack' OR estiloDeJogo == 'Gegenpress')
);

CREATE TABLE Equipa(
    idEquipa INT PRIMARY KEY,
    nomeEquipa VARCHAR(255) NOT NULL,
    jogosJogados TINYINT NOT NULL,
    nPontos TINYINT NOT NULL,
    classificacao TINYINT NOT NULL,
    golosMarcados TINYINT NOT NULL,
    golosSofridos TINYINT NOT NULL,
    vitorias TINYINT NOT NULL,
    derrotas TINYINT NOT NULL,
    empates TINYINT NOT NULL,

    idGrupo VARCHAR(1),
    tipoEstado VARCHAR(255),
    idTreinador INT,
    FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tipoEstado) REFERENCES Estados(tipoEstado) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idTreinador) REFERENCES Treinador(idTreinador) ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (idEquipa >= 1),
    CHECK (jogosJogados >= 0),
    CONSTRAINT check_nPontos CHECK (nPontos >= 0 AND nPontos <= 18),
    CONSTRAINT check_classificacao CHECK (classificacao <= 4 AND classificacao >= 1),
    CHECK (golosMarcados >= 0),
    CHECK (golosSofridos >= 0),
    CHECK (vitorias >= 0),
    CHECK (derrotas >= 0),
    CHECK (empates >= 0)
);


CREATE TABLE Jogador(
    idJogador INT PRIMARY KEY,
    nomeJogador VARCHAR(255) NOT NULL,
    nGolos TINYINT NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    numero TINYINT NOT NULL,
    jogosJogados TINYINT NOT NULL,
    tempoJogado TINYINT NOT NULL,
    posicao VARCHAR(255) NOT NULL,
    idade TINYINT NOT NULL,

    idEquipa INT,
    FOREIGN KEY (idEquipa) REFERENCES Equipa(idEquipa) ON UPDATE CASCADE ON DELETE CASCADE,


    CHECK (idJogador >= 1),
    CHECK (nGolos >= 0),
    CONSTRAINT check_numero CHECK (numero >=1 AND numero<=99),
    CHECK (jogosJogados >= 0),
    CHECK (tempoJogado >= jogosJogados * 1),
    CONSTRAINT check_posicao CHECK (posicao == 'GR' OR posicao == 'DD' OR posicao == 'DC' OR posicao == 'DE' OR posicao == 'MDC' OR posicao == 'MC' OR posicao == 'MCO' OR posicao == 'MD' OR posicao == 'ME' OR posicao == 'AC' OR posicao == 'PL' OR posicao == 'ED' OR posicao == 'EE'),
    CHECK (idade >= 14 AND idade <= 40)
);


CREATE TABLE Arbitro(
    idArbitro INT PRIMARY KEY,
    nomeArbitro VARCHAR(255) NOT NULL,
    idade TINYINT NOT NULL,
    nivel TINYINT NOT NULL,

    CHECK (idArbitro >= 1),
    CONSTRAINT check_idade CHECK (idade >= 17 AND idade <= 85),
    CONSTRAINT check_nivel CHECK (nivel>=1 AND nivel<=9)
);

CREATE TABLE Estadio(
    idEstadio INT PRIMARY KEY,
    nomeEstadio VARCHAR(255) NOT NULL,
    capacidade INT NOT NULL,
    anoInauguracao INT NOT NULL,

    CHECK (capacidade >= 0),
    CHECK (anoInauguracao >= 1860)
);

CREATE TABLE Jogo(
    idJogo INT PRIMARY KEY,
    eliminatoria VARCHAR(255),
    dataJogo VARCHAR(255) NOT NULL,
    idEquipaVisitada INT,
    idEquipaVisitante INT,
    idArbitro INT,
    idEstadio INT,
    nFaltasVisitada INT NOT NULL,
    nFaltasVisitante INT NOT NULL,
    posseDeBolaVisitada INT NOT NULL,
    posseDeBolaVisitante INT NOT NULL,
    cantosVisitada INT NOT NULL,
    cantosVisitante INT NOT NULL,
    rematesVisitada INT NOT NULL,
    rematesVisitante INT NOT NULL,
    passesCompletosVisitada INT NOT NULL,
    passesCompletosVisitante INT NOT NULL,
    rematesABalizaVisitada INT NOT NULL,
    rematesABalizaVisitante INT NOT NULL,
    golosVisitada INT NOT NULL,
    golosVisitante INT NOT NULL,


    FOREIGN KEY (eliminatoria) REFERENCES Estados(tipoEstado) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idEquipaVisitada) REFERENCES Equipa(idEquipa) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idEquipaVisitante) REFERENCES Equipa(idEquipa) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idArbitro) REFERENCES Arbitro(idArbitro) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idEstadio) REFERENCES Estadio(idEstadio) ON UPDATE CASCADE ON DELETE CASCADE,


    CHECK (nFaltasVisitada >= 0),
    CHECK (nFaltasVisitante >= 0),
    CHECK (posseDeBolaVisitada >= 0),
    CHECK (posseDeBolaVisitante >= 0),
    CHECK (cantosVisitada >= 0),
    CHECK (cantosVisitante >= 0),
    CHECK (rematesVisitada >= 0),
    CHECK (rematesVisitante >= 0),
    CHECK (passesCompletosVisitada >= 0),
    CHECK (passesCompletosVisitante >= 0),
    CHECK (rematesABalizaVisitada >= 0),
    CHECK (rematesABalizaVisitante >= 0),
    CHECK (golosVisitada >= 0),
    CHECK (golosVisitante >= 0)
);

CREATE TABLE EstatisticasJogador(
    tempoJogado INT NOT NULL,
    golosMarcados TINYINT NOT NULL,
    assistencias TINYINT NOT NULL,
    passesRealizados INT NOT NULL,
    cortesRealizados INT NOT NULL,
    cartoesAmarelos TINYINT NOT NULL,
    cartoesVermelhos TINYINT NOT NULL,
    faltasCometidas TINYINT NOT NULL,
    golosDefendidos INT NOT NULL,

    idJogador INT,
    idJogo INT,
    FOREIGN KEY (idJogador) REFERENCES Jogador(idJogador) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (idJogo) REFERENCES Jogo(idJogo) ON UPDATE CASCADE ON DELETE CASCADE,

    CHECK (tempoJogado >= 0),
    CHECK (golosMarcados >= 0),
    CHECK (assistencias >= 0),
    CHECK (passesRealizados >= 0),
    CHECK (cortesRealizados >= 0),
    CHECK (cartoesAmarelos >= 0),
    CHECK (cartoesVermelhos >= 0),
    CHECK (faltasCometidas >= 0),
    CHECK (golosDefendidos >= 0)
);

.read povoar.sql
