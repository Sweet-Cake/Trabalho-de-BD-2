package controle;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Lista;

/**
 * Servlet implementation class Teste
 */
@WebServlet("/Teste")
public class Teste extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Teste() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String msg = request.getParameter("cmd");
		Lista lista = new Lista();
		System.out.println(msg);
		switch (msg.toLowerCase()){
		case "inicial":
			try {
				msg = lista.ListaModalidadea();
				System.out.println(msg);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			PrintWriter sair = response.getWriter();
			sair = response.getWriter();
		    sair.print(msg);
		    break;
		case "final":
			try {
				msg = lista.ListaFinalista();
				System.out.println(msg);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			sair = response.getWriter();
		    sair.print(msg);
		    break;
		case "prova":
			try {
				String prova = request.getParameter("prova");
				System.out.println(prova);
				msg = lista.ListaAtletaInicial(prova);
				System.out.println(msg);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			sair = response.getWriter();
		    sair.print(msg);
		    break;
		case "provaf":
			try {
				String prova = request.getParameter("prova");
				System.out.println(prova);
				msg = lista.ListaAtletaFinalista(prova);
				System.out.println(msg);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			sair = response.getWriter();
		    sair.print(msg);
		    break;
		case "recorde":
			try {
				String prova = request.getParameter("prova");
				System.out.println(prova);
				msg = lista.RecebeRecorde(prova, 1);
				System.out.println(msg);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			sair = response.getWriter();
		    sair.print(msg);
		    break;
		}
		
	}


}
