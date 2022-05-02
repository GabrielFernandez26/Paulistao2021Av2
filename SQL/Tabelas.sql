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
(1, 'Botafogo', 'Ribeir�o Preto', 'Santa Cruz'),
(2, 'Corinthians', 'S�o Paulo', 'Neo Qu�mica Arena'),
(3, 'Ferrovi�ria', 'Araraquara', 'Fonte Luminosa'),
(4, 'Guarani', 'Campinas', 'Brinco de Ouro'),
(5, 'Inter de Limeira', 'Limeira', 'Limeir�o'),
(6, 'Ituano', 'Itu', 'Novelli J�nior'),
(7, 'Mirassol', 'Mirassol', 'Jos� Maria de Campos Maia'),
(8, 'Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
(9, 'Palmeiras', 'S�o Paulo', 'Allianz Parque'),
(10, 'Ponte Preta', 'Campinas', 'Mois�s Lucarelli'),
(11, 'Red Bull Bragantino', 'Bragan�a Paulista', 'Nabi Abi Chedid'),
(12, 'Santo Andr�', 'Santo Andr�', 'Bruno Jos� Daniel'),
(13, 'Santos', 'Santos', 'Vila Belmiro'),
(14, 'S�o Bento', 'Sorocaba', 'Walter Ribeiro'),
(15, 'S�o Caetano', 'S�o Caetano do Sul', 'Anacleto Campanella'),
(16, 'S�o Paulo', 'S�o Paulo', 'Morumbi')