package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.com.fatec.zl.SpringPaulistao2021.model.Resultado;

@Repository("classificacaoDao")
public class ClassificacaoDao implements IClassificacaoDao{
	
	@Autowired
	public GenericDao gDao;
	public ClassificacaoDao(GenericDao gDao) {
		this.gDao = gDao;
	}
	
	@Override
	public List<Resultado> classificacaoGeral() throws SQLException, ClassNotFoundException {
		List<Resultado> resultados = new ArrayList<Resultado>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vwClassificacaoGeral"
					+ " ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Resultado r = new Resultado();
			r.setTime(rs.getString("nomeTime"));
			r.setPartidas(rs.getInt("partidas"));
			r.setVitorias(rs.getInt("vitorias"));
			r.setEmpates(rs.getInt("empates"));
			r.setDerrotas(rs.getInt("derrotas"));
			r.setGolsMarcados(rs.getInt("golsMarcados"));
			r.setGolsSofridos(rs.getInt("golsSofridos"));
			r.setSaldoGols(rs.getInt("saldoGols"));
			r.setPontos(rs.getInt("pontos"));
			resultados.add(r);
		}
		return resultados;
	}

	@Override
	public List<Resultado> classificacaoPorGrupo(String grupo) throws SQLException, ClassNotFoundException {
		List<Resultado> resultados = new ArrayList<Resultado>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM dbo.fn_classificacao(?)"
					+" ORDER BY pontos DESC, vitorias DESC, golsMarcados DESC, saldoGols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			Resultado r = new Resultado();
			r.setTime(rs.getString("nomeTime"));
			r.setPartidas(rs.getInt("partidas"));
			r.setVitorias(rs.getInt("vitorias"));
			r.setEmpates(rs.getInt("empates"));
			r.setDerrotas(rs.getInt("derrotas"));
			r.setGolsMarcados(rs.getInt("golsMarcados"));
			r.setGolsSofridos(rs.getInt("golsSofridos"));
			r.setSaldoGols(rs.getInt("saldoGols"));
			r.setPontos(rs.getInt("pontos"));
			resultados.add(r);
		}	
		
		return resultados;
		
	}
	

}
