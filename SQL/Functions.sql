--FUNCTIONS

USE db_paulistao

--FUNCTION DE GERAR CLASSIFICAÇÃO
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
		AND j.dia IS NOT NULL
    GROUP BY t.nomeTime
)

--FUNCTION DE GERAR QUARTAS DE FINAL
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
