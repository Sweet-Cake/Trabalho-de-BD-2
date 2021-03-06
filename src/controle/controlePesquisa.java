package controle;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Insert;
import model.Desempenho;

/**
 * Servlet implementation class controlePesquisa
 */
@WebServlet("/controlePesquisa")
public class controlePesquisa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public controlePesquisa() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Insert i=new Insert();
		String prova = request.getParameter("prova");
		String bateria = request.getParameter("bateria");
		String fase=request.getParameter("fase");
		String prova1=request.getParameter("prova1");
		String fase1 =request.getParameter("fase1");
		String msg = request.getParameter("cmd");
		switch (msg.toLowerCase()){
			case "ir":
			try {
				List<Desempenho> d=i.buscar(prova, bateria, fase);
				request.setAttribute("DESEMPENHO" , d );
				System.out.println("OK");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			RequestDispatcher rd = request.getRequestDispatcher("./Index.jsp");
			rd.forward(request, response);
			break;
			case "buscar":
				try {
					List<Desempenho> p=i.Prova(fase1,prova1);
					request.setAttribute("PROVA" , p );
					System.out.println("OK");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				RequestDispatcher rd2 = request.getRequestDispatcher("./Index.jsp");
				rd2.forward(request, response);
			break;
			default:
				System.out.println("Nothin' to see here, kiddo");
			break;
		}
	}

}
