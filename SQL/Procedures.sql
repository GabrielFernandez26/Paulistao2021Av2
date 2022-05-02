--PROCEDURES
USE db_paulistao

--PROCEDURE DE GERAR OS GRUPOS
CREATE PROCEDURE sp_divideGrupos
AS
	DECLARE @qtdTimes INT,
			@cont INT,
			@cod_grupo INT
	SET @cont = (select COUNT(*) from Grupos) + 1
	IF @cont = 1
	BEGIN
		INSERT INTO grupos VALUES 
		(2,'A'),
		(9,'B'),
		(13,'C'),
		(16,'D')
	END
	SET @qtdTimes = (SELECT COUNT(nomeTime) FROM times)
	
	WHILE (@cont <= @qtdTimes)
	BEGIN 
		SET @cod_grupo = CAST(RAND()*(5 - 1) + 1 AS INT)
		IF (@cont != 2 AND @cont != 9 AND @cont != 13 AND @cont != 16)
		BEGIN
			IF @cod_grupo = 1 
			BEGIN
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

--PROCEDURE DE GERAR JOGOS
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

--PROCEDURE AUXILIAR DE GERAR JOGOS
CREATE PROC sp_auxGerarJogos
AS
	
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

--PROCEDURE DE GERAR DATAS
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