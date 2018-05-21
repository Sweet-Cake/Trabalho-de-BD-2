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
	public String ListaAtletaInicial(String prova) throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("select * FROM dbo.fn_pesquisaatleta(?) as tabela");
		pstmt.setString(1,prova);
		ResultSet rs = pstmt.executeQuery();
		List<Atleta> atleta = new ArrayList<Atleta>();
		System.out.println("fu-ta-ri");
		System.out.println("harururun");
		String msg = "<option value='0' style='width:150px;'>Natalia</option>";
		while(rs.next()) { 
			Atleta a = new Atleta();
			msg = msg + "<option value='"+rs.getInt("cod") + "' style='width:150px'>"+rs.getString("nome")+"</option>";
		}
		return msg;
	}
	public String ListaAtletaFinalista(String prova) throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("exec sp_listaatletasf ?");
		pstmt.setString(1,prova);
		ResultSet rs = pstmt.executeQuery();
		List<Atleta> atleta = new ArrayList<Atleta>();
		System.out.println("kitta!!!");
		System.out.println("you are my angel <3");
		String msg = "<option value='0' style='width:150px;'>Layla</option>";
		while(rs.next()) { 
			Atleta a = new Atleta();
			msg = msg + "<option value='"+rs.getInt("cod") + "' style='width:150px'>"+rs.getString("nome")+"</option>";
		}
		return msg;
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
	public String ListaModalidadea() throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("SELECT * FROM prova");
		ResultSet rs = pstmt.executeQuery();
		List<Prova> prova = new ArrayList<Prova>();
		String msg = "<option value='0' style='width:150px;'>Calie</option>";
		while(rs.next()) { 
			Prova p = new Prova();
			msg = msg + "<option value='"+rs.getInt("tipo") + "' style='width:150px'>"+rs.getString("prova")+"</option>";
		}
		return msg;
	}
	
	public String RecebeRecorde(String prova, int tipo) throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("exec sp_pegarecorde ?, ?");
		pstmt.setString(1,prova);
		pstmt.setInt(2, tipo);
		ResultSet rs = pstmt.executeQuery();
		String msg = "";
		while(rs.next()) { 
			Prova p = new Prova();
			msg = rs.getString("resultado");
		}
		return msg;
	}
	
	/*public List<Prova> ListaFinalista() throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("select * FROM dbo.fn_pesquisaFinal() as tabela");
		ResultSet rs = pstmt.executeQuery();
		List<Prova> prova = new ArrayList<Prova>();
		while(rs.next()) { 
			Prova p = new Prova();
			p.setProva(rs.getString("prova"));
			p.setTipo(rs.getInt("tipo"));
			prova.add(p);
		}
		return prova;
	}*/
	
	public String ListaFinalista() throws SQLException {
		Connection con = (Connection) GenericDao.getInstance().getConnection();
		PreparedStatement pstmt = (PreparedStatement) con.prepareStatement("select * FROM dbo.fn_pesquisaFinal() as tabela");
		ResultSet rs = pstmt.executeQuery();
		List<Prova> prova = new ArrayList<Prova>();
		String msg = "<option value='0' style='width:150px;'>Marie</option>";
		while(rs.next()) { 
			Prova p = new Prova();
			msg = msg + "<option value='"+rs.getInt("tipo") + "' style='width:150px'>"+rs.getString("prova")+"</option>";
		}
		return msg;
	}
}
