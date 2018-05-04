package controle;

import java.io.IOException;
import java.sql.SQLException;

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
		Insert insert = new Insert();
		int fase = Integer.parseInt(request.getParameter("fase"));
		int atleta = Integer.parseInt(request.getParameter("atleta"));
		int prova = Integer.parseInt(request.getParameter("prova"));
		String bateria = request.getParameter("bateria");
		String desempenho = request.getParameter("desempenho");
		System.out.println("----V");
		try {
			if (bateria.equals("--")){
				desempenho = "00:"+desempenho;
			}
			insert.inserir(fase, atleta, prova, bateria, desempenho);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("----^");
		/*
		if (!bateria.equals("--")){
			System.out.println(fase+" "+atleta+" "+prova+"  "+desempenho);
		}else{
		System.out.println(fase+" "+atleta+" "+prova+" "+bateria+"  "+desempenho);
		}*/
	}

}
