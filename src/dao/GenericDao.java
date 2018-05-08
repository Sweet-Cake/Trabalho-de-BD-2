package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.swing.JOptionPane;
public class GenericDao {

	private final static String USERNAME = "user";
	private final static String PASSWORD = "123456";
	private final static String URLDB = "jdbc:jtds:sqlserver://localhost:49424/databasename=atletismo;instance=MSSQLSERVER;";
	private static GenericDao instancia;
	private Connection con;

	private GenericDao() {
		
		//Conexão raíz = Class.forName("net.sourceforge.jtds.jdbc.Driver")
		// Conexão nutella = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		System.out.println("concon!");
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			System.out.println("ponpon!");
			con = DriverManager.getConnection("jdbc:jtds:sqlserver://localhost:1433;DatabaseName=atletismo;namedPipe=true",
					"user", "123456");
		} catch (ClassNotFoundException | SQLException e) {
			JOptionPane.showMessageDialog(null, e.getMessage(), "ERRO", JOptionPane.ERROR_MESSAGE);
		}
		System.out.println("ponpon!");
	}

	public static GenericDao getInstance() {
		if (instancia == null)
			instancia = new GenericDao();
		return instancia;
	}

	public Connection getConnection() {
		return con;
	}
}