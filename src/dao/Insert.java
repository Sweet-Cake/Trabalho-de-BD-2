package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Insert {
	 Connection con = (Connection) GenericDao.getInstance().getConnection();
	
	public void inserir(int fase, int atleta, int prova, String bateria, String desempenho) throws SQLException{
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement ps = (PreparedStatement) con.prepareStatement("exec sp_adiciona ?,?,?,?,?");
		ps.setInt(1,prova);
		ps.setInt(2, atleta);
		ps.setInt(3, fase);
		ps.setString(4,bateria);
		ps.setString(5,desempenho);
		ps.execute();
		ps.close();
	}
}
