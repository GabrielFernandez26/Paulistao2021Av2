package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.fatec.zl.SpringPaulistao2021.model.Resultado;


public interface IClassificacaoDao {
	public List<Resultado> classificacaoGeral() throws SQLException, ClassNotFoundException;
	public List<Resultado> classificacaoPorGrupo(String grupo) throws SQLException, ClassNotFoundException;

}
