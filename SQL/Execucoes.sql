--EXECUÇÕES DE PROCEDURES E FUNCTIONS
USE db_paulistao

EXEC sp_divideGrupos

EXEC sp_auxGerarJogos

EXEC sp_datasRodada

SELECT * FROM vwClassificacaoGeral
ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC

SELECT * FROM fn_QuartasDeFinal()

