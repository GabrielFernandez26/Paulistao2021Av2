package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.fatec.zl.SpringPaulistao2021.model.Grupo;

public interface IGrupoDao {
	public void gerarGrupos() throws SQLException, ClassNotFoundException;
	public List<Grupo> listarGrupos() throws SQLException, ClassNotFoundException;
}
