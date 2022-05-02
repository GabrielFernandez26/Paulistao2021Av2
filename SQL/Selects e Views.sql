--VIEWS E SELECTS
USE db_paulistao

--VIEW COM DADOS DOS TIMES NOS GRUPOS
CREATE VIEW vwGrupos AS
	SELECT g.letra AS grupo, t.nomeTime AS participantes, t.cidade, t.estadio, g.codigoTime AS codigo_time
	FROM grupos g
	LEFT JOIN times t
	ON g.codigoTime = t.codigoTime

SELECT * FROM vwGrupos ORDER BY grupo

--VIEW COM DADOS DOS JOGOS
CREATE VIEW vwJogos
AS
	SELECT j.codigoJogo, j.codigoTimeA, j.codigoTimeB, j.golsTimeA, j.golsTimeB, j.dia,
	t1.nomeTime AS timeA, t2. nomeTime AS timeB
	FROM jogos j
	LEFT JOIN times t1 ON
	j.codigoTimeA = t1.codigoTime 
	LEFT JOIN times t2 ON
	j.codigoTimeB = t2.codigoTime 

SELECT * FROM vwJogos ORDER BY dia

--VIEW DA CLASSIFICAÇÃO GERAL
CREATE VIEW vwClassificacaoGeral
AS
	SELECT * FROM dbo.fn_classificacao('A')
	UNION ALL
	SELECT * FROM dbo.fn_classificacao('B')
	UNION ALL 
	SELECT * FROM dbo.fn_classificacao('C')
	UNION ALL 
	SELECT * FROM dbo.fn_classificacao('D')

--SELECTS DA CLASSIFICACAO DE CADA GRUPO
SELECT * FROM dbo.fn_classificacao('A')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('B')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('C')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM dbo.fn_classificacao('D')
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC


--SELECT DAS QUARTAS
SELECT * FROM fn_QuartasDeFinal()

SELECT * FROM jogos WHERE dia IS NOT NULL
