CREATE DATABASE db_paulistao
GO
USE db_paulistao
GO
--Criação das tabelas
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
SELECT * FROM grupos
SELECT * FROM times
SELECT * FROM jogos
--Insert na tabela times
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

--Procedure responsável pela geração dos grupos
CREATE PROCEDURE sp_divideGrupos
AS
	DECLARE @qtdTimes INT,
			@cont INT,
			@cod_grupo INT
	SET @cont = (select COUNT(*) from Grupos) + 1
	--Inserindo os cabeças de chave
	IF @cont = 1
	BEGIN
		INSERT INTO grupos VALUES 
		(2,'A'),
		(9,'B'),
		(13,'C'),
		(16,'D')
	END
	SET @qtdTimes = (SELECT COUNT(nomeTime) FROM times)
	--Inserindo os outros times no grupo, enquanto a quantidade do contador for igual a quantidade dos times
	WHILE (@cont <= @qtdTimes)
	BEGIN 
	--Gerando id randomico
		SET @cod_grupo = CAST(RAND()*(5 - 1) + 1 AS INT)
		--Vereficando os não exclusivos
		IF (@cont != 2 AND @cont != 9 AND @cont != 13 AND @cont != 16)
		BEGIN
			--Verificação de qual grupo é
			IF @cod_grupo = 1 
			BEGIN
				--Caso for 1 será o A e assim por diante até o D
				IF (SELECT COUNT(*) FROM grupos WHERE letra = 'A') < 4
				BEGIN
					INSERT INTO grupos VALUES (@cont, 'A')
					SET @cont = @cont + 1
					CONTINUE
				END
			END

			IF @cod_grupo = 2 
			BEGIN
				IF (SELECT COUNT(*) FROM grupos WHERE letra = 'B') < 4
				BEGIN
					INSERT INTO grupos VALUES (@cont, 'B')
					SET @cont = @cont + 1
					CONTINUE
				END
			END
			IF @cod_grupo = 3 
				IF (SELECT COUNT(*) FROM grupos WHERE letra = 'C') < 4
				BEGIN
					INSERT INTO grupos VALUES (@cont, 'C')
					SET @cont = @cont + 1
					CONTINUE
				END
			IF @cod_grupo = 4 
			BEGIN
				IF (SELECT COUNT(*) FROM grupos WHERE letra = 'D') < 4
				BEGIN
					INSERT INTO grupos VALUES (@cont, 'D')
					SET @cont = @cont + 1
					CONTINUE
				END
			END
		END
		ELSE
		BEGIN
			SET @cont = @cont + 1
		END 
	END
--View com dados dos times nos grupos
	CREATE VIEW vwGrupos AS
		SELECT g.letra AS grupo, t.nomeTime AS participantes, t.cidade, t.estadio, g.codigoTime AS codigo_time
		FROM grupos g
		LEFT JOIN times t
		ON g.codigoTime = t.codigoTime

	SELECT * FROM vwGrupos ORDER BY grupo
	
	EXEC sp_divideGrupos 

--Procedure responsável pela geração dos confrontos
CREATE PROCEDURE sp_jogos (@letra VARCHAR(2))
AS
	
	DECLARE @a AS TABLE (id INT IDENTITY, CodigoA INT)
	DECLARE @b AS TABLE (id INT IDENTITY, CodigoB INT)
	DECLARE @datas AS TABLE(dias DATE)

	INSERT INTO @a SELECT codigoTime AS CodigoA FROM grupos WHERE letra = SUBSTRING(@letra,1,1)
	INSERT INTO @b SELECT codigoTime AS CodigoB FROM grupos WHERE letra = SUBSTRING(@letra,2,1)

	INSERT INTO jogos
	SELECT DISTINCT A.CodigoA, B.CodigoB, ABS(CHECKSUM(NEWID()) % 5), ABS(CHECKSUM(NEWID()) % 5), NULL
	FROM @a A, @b B
	WHERE A.CodigoA <> B.CodigoB

--Procedure auxiliar da geração de de jogos
CREATE PROC sp_auxGerarJogos
AS
	TRUNCATE TABLE jogos
	DECLARE @vet_letras VARCHAR(2),
			@cont		INT
	SET @cont = 1
	WHILE @cont <= 6
		BEGIN
		SET @vet_letras = 
		CASE 
			WHEN @cont = 1 THEN 'AB'
			WHEN @cont = 2 THEN 'CD'
			WHEN @cont = 3 THEN 'AC'
			WHEN @cont = 4 THEN 'BC'
			WHEN @cont = 5 THEN 'AD'
			WHEN @cont = 6 THEN 'BD'
		END
		SET @cont = @cont + 1
		EXEC sp_jogos @vet_letras
	END

EXEC sp_auxGerarJogos
SELECT * FROM jogos 

CREATE PROCEDURE sp_datasRodada
AS
	DECLARE @data			DATE,
			@id				INT,
			@qtd			INT,
			@data_inicial	DATE
	SET @id = 1
	SET @data_inicial = '2021-02-28'
	WHILE @id <= 96
	BEGIN
		SET @data =
			CASE
				WHEN @id IN ( 1,  6, 11, 16, 17, 22, 27, 32) THEN DATEADD(DAY,0,@data_inicial) 
				WHEN @id IN ( 2,  7, 12, 13, 18, 23, 28, 29) THEN DATEADD(DAY,3,@data_inicial)   
				WHEN @id IN ( 3,  8,  9, 14, 19, 24, 25, 30) THEN DATEADD(DAY,7,@data_inicial)
				WHEN @id IN ( 4,  5, 10, 15, 20, 21, 26, 31) THEN DATEADD(DAY,10,@data_inicial)
				WHEN @id IN (33, 38, 43, 48, 49, 54, 59, 64) THEN DATEADD(DAY,14,@data_inicial) 
				WHEN @id IN (34, 39, 44, 45, 50, 55, 60, 61) THEN DATEADD(DAY,17,@data_inicial) 
				WHEN @id IN (35, 40, 41, 46, 51, 56, 57, 62) THEN DATEADD(DAY,20,@data_inicial) 
				WHEN @id IN (36, 37, 42, 47, 52, 53, 58, 63) THEN DATEADD(DAY,24,@data_inicial)
				WHEN @id IN (65, 70, 75, 80, 81, 86, 91, 96) THEN DATEADD(DAY,27,@data_inicial)
				WHEN @id IN (66, 71, 76, 77, 82, 87, 92, 93) THEN DATEADD(DAY,30,@data_inicial)
				WHEN @id IN (67, 72, 73, 78, 83, 88, 89, 94) THEN DATEADD(DAY,34,@data_inicial)
				WHEN @id IN (68, 69, 74, 79, 84, 85, 90, 95) THEN DATEADD(DAY,37,@data_inicial) 
			END
			UPDATE jogos
				SET dia = @data
				WHERE codigoJogo = @id
			
			SET @id = @id + 1
	END
EXEC sp_datasRodada

SELECT * FROM jogos

CREATE VIEW vwJogos
AS
	SELECT j.codigoJogo, j.codigoTimeA, j.codigoTimeB, j.golsTimeA, j.golsTimeB, j.dia,
	t1.nomeTime AS timeA, t2. nomeTime AS timeB
	FROM jogos j
	LEFT JOIN times t1 ON
	j.codigoTimeA = t1.codigoTime 
	LEFT JOIN times t2 ON
	j.codigoTimeB = t2.codigoTime 


--Function de gerar classificação
CREATE FUNCTION fn_classificacao(@letra varchar)
RETURNS TABLE RETURN(
	SELECT t.nomeTime,
	count(1) AS partidas,
	SUM(IIF(j.codigoTimeA = g.codigoTime, IIF(j.golsTimeA > j.golsTimeB, 1, 0), IIF(j.golsTimeB > j.golsTimeA, 1, 0))) AS vitorias,
    SUM(IIF(j.codigoTimeA = g.codigoTime, IIF(j.golsTimeA = j.golsTimeB, 1, 0), IIF(j.golsTimeB = j.golsTimeA, 1, 0))) AS empates,
    SUM(IIF(j.codigoTimeA = g.codigoTime, IIF(j.golsTimeA < j.golsTimeB, 1, 0), IIF(j.golsTimeB < j.golsTimeA, 1, 0))) AS derrotas,
    SUM(IIF(j.codigoTimeA = g.codigoTime, j.golsTimeA, j.golsTimeB)) AS golsMarcados,
    SUM(IIF(j.codigoTimeA = g.codigoTime, j.golsTimeB, j.golsTimeA)) AS golsSofridos,
    SUM(IIF(j.codigoTimeA = g.codigoTime,  j.golsTimeA - j.golsTimeB, j.golsTimeB -  j.golsTimeA)) AS saldoGols,
    SUM(CASE
        WHEN (j.codigoTimeA = g.codigoTime AND j.golsTimeA > j.golsTimeB) OR (j.codigoTimeB = g.codigoTime AND j.golsTimeB > j.golsTimeA) THEN 3
        WHEN j.golsTimeA = j.golsTimeB THEN 1
    END) AS pontos
    FROM jogos j , times t, grupos g
    WHERE (j.codigoTimeA = g.codigoTime OR j.codigoTimeB = g.codigoTime)
        AND t.codigoTime = g.codigoTime
        AND letra = @letra
    GROUP BY t.nomeTime
)
CREATE VIEW vwClassificacaoGeral
AS
	SELECT * FROM dbo.fn_classificacao('A')
	UNION ALL
	SELECT * FROM dbo.fn_classificacao('B')
	UNION ALL 
	SELECT * FROM dbo.fn_classificacao('C')
	UNION ALL 
	SELECT * FROM dbo.fn_classificacao('D')

SELECT * FROM vwClassificacaoGeral
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC


SELECT * FROM dbo.fn_classificacao('A')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('B')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('C')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('D')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

CREATE FUNCTION fn_QuartasDeFinal()
RETURNS @jogos TABLE(
NomeTimeA VARCHAR(50),
NomeTimeB VARCHAR(50)
)
AS
BEGIN
	DECLARE @vetorGrupos VARCHAR(5), @cont INT, @NomeTimeA VARCHAR(50), @NomeTimeB VARCHAR(50)
	DECLARE  @tabelaGrupo TABLE
	(indice int NULL , nomeTime varchar(50) NULL)
	SET @vetorGrupos = 'ABCD'
	SET @cont = 1
	WHILE @cont <= 4
	BEGIN
		DELETE FROM @tabelaGrupo
		INSERT INTO @tabelaGrupo (indice,nomeTime) SELECT TOP 2 ROW_NUMBER() OVER (ORDER BY pontos DESC, vitorias, golsMarcados, saldoGols) AS id,nomeTime FROM fn_classificacao(SUBSTRING(@vetorGrupos, @cont, 1)) ORDER BY pontos DESC, vitorias, golsMarcados, saldoGols
		SET @NomeTimeA = (SELECT nomeTime FROM @tabelaGrupo WHERE indice = 1)
		SET @NomeTimeB = (SELECT nomeTime FROM @tabelaGrupo WHERE indice = 2)
		INSERT INTO @jogos VALUES (@NomeTimeA,@NomeTimeB)
		SET @cont = @cont + 1
	END
	RETURN
END



-----------------TRIGGERS-----------------
---------------------------------
CREATE TRIGGER t_blockDelInsertUpdateTimes ON times
FOR DELETE, INSERT, UPDATE 
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido alterar registros de times', 16, 1)
END
GO
CREATE TRIGGER t_blockInsertDeleteJogos ON jogos
AFTER INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido alterar registros de Jogos', 16, 1)
END
GO
CREATE TRIGGER t_blockUpdateInsertDeleteGrupos ON grupos
FOR UPDATE, INSERT, DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não é permitido alterar registros de Grupos', 16, 1)
END