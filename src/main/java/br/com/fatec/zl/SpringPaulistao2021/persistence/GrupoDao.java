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

import br.com.fatec.zl.SpringPaulistao2021.model.Grupo;
import br.com.fatec.zl.SpringPaulistao2021.model.Time;

@Repository
public class GrupoDao implements IGrupoDao {
	
	@Autowired
	private GenericDao gDao;  
	public GrupoDao(GenericDao gDao) throws ClassNotFoundException, SQLException {
		this.gDao = gDao;
	}

	@Override
	public void gerarGrupos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "CALL sp_divideGrupos";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
		c.close();

	}

	@Override
	public List<Grupo> listarGrupos() throws SQLException, ClassNotFoundException {
		List<Grupo> grupos = new ArrayList<Grupo>();
		grupos.add(findByName("A"));
		grupos.add(findByName("B"));
		grupos.add(findByName("C"));
		grupos.add(findByName("D"));

		return grupos;

	}

	public Grupo findByName(String nome) throws SQLException, ClassNotFoundException {
		Grupo grupo = new Grupo();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM vwGrupos WHERE grupo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, nome);
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			grupo.setNome(rs.getString("grupo"));
			Time t = new Time();
			t.setNome(rs.getString("participantes"));
			t.setCidade(rs.getString("cidade"));
			t.setEstadio(rs.getString("estadio"));
			t.setCodigoTime(rs.getInt("codigo_time"));
			grupo.addTime(t);
			
		}

		rs.close();
		ps.close();
		c.close();

		return grupo;
	}


}
