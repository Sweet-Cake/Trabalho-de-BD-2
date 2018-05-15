package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Desempenho;

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
	public List<Desempenho> buscar(String prova,  String bateria, String fase) throws SQLException{
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement ps = (PreparedStatement) con.prepareStatement("select * FROM dbo.fn_tabelaDes(?,?,?) as tabela");
		ps.setString(1,prova);
		ps.setString(2,bateria);
		ps.setString(3,fase);
		ResultSet rs=ps.executeQuery();
		List<Desempenho> des = new ArrayList<Desempenho>();
		while(rs.next()) {
			Desempenho d = null;
			d=new Desempenho();
			d.setCodAtl(rs.getInt("Codigo"));
			d.setNome(rs.getString("Nome"));
			d.setPais(rs.getString("Pais"));
			d.setResultado(rs.getString("Resultado"));
			System.out.println("passei");
			des.add(d);
		}
		return des;
	}
	public List<Desempenho> Prova(String fase,String prova) throws SQLException{
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement ps = (PreparedStatement) con.prepareStatement("select * FROM dbo.fn_tabelaProva(?,?) as tabelap");
		ps.setString(1,fase);
		ps.setString(2,prova);
		ResultSet rs=ps.executeQuery();
		List<Desempenho> des = new ArrayList<Desempenho>();
		while(rs.next()) {
			Desempenho d = null;
			d=new Desempenho();
			d.setCodAtl(rs.getInt("Codigo"));
			d.setNome(rs.getString("Nome"));
			d.setPais(rs.getString("Pais"));
			d.setResultado(rs.getString("Resultado"));
			System.out.println("passei2");
			des.add(d);
		}
		return des;
	}
}