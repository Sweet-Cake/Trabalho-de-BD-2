package controle;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Insert;

/**
 * Servlet implementation class controleAdd
 */
@WebServlet("/controleAdd")
public class controleAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public controleAdd() {
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
		// TODO Auto-generated method stub
		String fase = request.getParameter("fase");
		String atleta = request.getParameter("atleta");
		String prova = request.getParameter("prova");
		String bateria = request.getParameter("bateria");
		String desempenho = request.getParameter("desempenho");
		if (bateria.equals("--")){
			System.out.println(fase+" "+atleta+" "+prova+"  "+desempenho);
		}else{
		System.out.println(fase+" "+atleta+" "+prova+" "+bateria+"  "+desempenho);
		}
	}

}
