package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.fatec.zl.SpringPaulistao2021.model.Jogo;

public interface IJogoDao {
	public void gerarJogos() throws SQLException, ClassNotFoundException;
	public List<Jogo> listarJogos() throws SQLException, ClassNotFoundException;
	public List<Jogo> buscarJogoPorData(String data) throws SQLException, ClassNotFoundException;
	public List<Jogo> listarQuartas() throws SQLException, ClassNotFoundException;
	
}
