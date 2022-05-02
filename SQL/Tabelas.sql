--TABELAS E INSERT DE JOGOS
USE db_paulistao

CREATE TABLE times (
	codigoTime INT NOT NULL,
	nomeTime VARCHAR(100),
	cidade VARCHAR(100),
	estadio VARCHAR (200),
	PRIMARY KEY(codigoTime)
)
GO
CREATE TABLE grupos (
	codigoTime INT,
	letra VARCHAR(1) CHECK(letra = 'A' OR letra = 'B' OR letra = 'C' OR letra = 'D'),
	PRIMARY KEY (codigoTime, letra),
	FOREIGN KEY (codigoTime) REFERENCES times(codigoTime)
)
GO
CREATE TABLE jogos (
	codigoJogo	INT NOT NULL IDENTITY,
	codigoTimeA INT NOT NULL,
	codigoTimeB INT NOT NULL,
	golsTimeA INT,
	golsTimeB INT,
	dia DATE 
	PRIMARY KEY (codigoJogo)
	FOREIGN KEY (codigoTimeA) REFERENCES times (codigoTime),
	FOREIGN KEY (codigoTimeB) REFERENCES times (codigoTime),
)

INSERT INTO times VALUES
(1, 'Botafogo', 'Ribeirão Preto', 'Santa Cruz'),
(2, 'Corinthians', 'São Paulo', 'Neo Química Arena'),
(3, 'Ferroviária', 'Araraquara', 'Fonte Luminosa'),
(4, 'Guarani', 'Campinas', 'Brinco de Ouro'),
(5, 'Inter de Limeira', 'Limeira', 'Limeirão'),
(6, 'Ituano', 'Itu', 'Novelli Júnior'),
(7, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia'),
(8, 'Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
(9, 'Palmeiras', 'São Paulo', 'Allianz Parque'),
(10, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli'),
(11, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid'),
(12, 'Santo André', 'Santo André', 'Bruno José Daniel'),
(13, 'Santos', 'Santos', 'Vila Belmiro'),
(14, 'São Bento', 'Sorocaba', 'Walter Ribeiro'),
(15, 'São Caetano', 'São Caetano do Sul', 'Anacleto Campanella'),
(16, 'São Paulo', 'São Paulo', 'Morumbi')