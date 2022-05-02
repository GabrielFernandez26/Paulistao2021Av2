package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.com.fatec.zl.SpringPaulistao2021.model.Jogo;
@Repository
public class JogoDao implements IJogoDao {
	
	@Autowired
	public GenericDao gDao;
	public JogoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void gerarJogos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_auxGerarJogos";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
		c.close();
	}

	@Override
	public List<Jogo> listarJogos() throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vwJogos WHERE dia IS NOT NULL";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogo j = new Jogo();
			j.setCodigoJogo(rs.getInt("codigoJogo"));
			j.setTimeA(rs.getString("timeA"));
			j.setTimeB(rs.getString("timeB"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dia"));
			
			jogos.add(j);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return jogos;
	}

	@Override
	public List<Jogo> buscarJogoPorData(String data) throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vwJogos WHERE dia = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, data);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogo j = new Jogo();
			j.setCodigoJogo(rs.getInt("codigoJogo"));
			j.setTimeA(rs.getString("timeA"));
			j.setTimeB(rs.getString("timeB"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeA(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dia"));
			
			jogos.add(j);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return jogos;
	}

	@Override
	public List<Jogo> listarQuartas() throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM fn_QuartasDeFinal()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogo j = new Jogo();
			j.setTimeA(rs.getString("NomeTimeA"));
			j.setTimeB(rs.getString("NomeTimeB"));
			jogos.add(j);
		}
		
		return jogos;
	}
	
}
