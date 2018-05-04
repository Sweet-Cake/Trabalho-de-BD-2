package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Atleta;
import model.Prova;
public class Lista {
	public List<Atleta> ListaAtleta() throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("SELECT * FROM atleta");
		ResultSet rs = pstmt.executeQuery();
		List<Atleta> atleta = new ArrayList<Atleta>();
		System.out.println("fu-ta-ri");
		while(rs.next()) { 
			Atleta a = new Atleta();
			a.setCod(rs.getInt("cod"));
			a.setNome(rs.getString("nome"));
			atleta.add(a);
		}
		return atleta;
	}
	public List<Prova> ListaModalidade() throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("SELECT * FROM prova");
		ResultSet rs = pstmt.executeQuery();
		List<Prova> prova = new ArrayList<Prova>();
		while(rs.next()) { 
			Prova p = new Prova();
			p.setCod(rs.getInt("cod"));
			p.setProva(rs.getString("prova"));
			p.setTipo(rs.getInt("tipo"));
			prova.add(p);
		}
		return prova;
	}
}
