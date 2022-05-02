package br.com.fatec.zl.SpringPaulistao2021.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Component;
@Component
public class GenericDao {
private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException{
		String hostName = "127.0.01";
		String dbName = "db_paulistao";
		String user = "sa";
		String senha = "gabriel";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		String connect =
		String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s",
				hostName, dbName, user, senha);
		c = DriverManager.getConnection(connect);
		
		return c;
	}
	
}