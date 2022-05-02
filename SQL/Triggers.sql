--TRIGGERS
USE db_paulistao

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