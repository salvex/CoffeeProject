package com.coffee.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.coffee.model.MachineService;

/**
 * Servlet implementation class LogoutController
 */
@WebServlet({ "/LogoutController", "/Logout" })
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session.getAttribute("user") != null || session != null) {
			if(session.getAttribute("machine_id") != null) {
				try {
					MachineService ms = new MachineService();
					int idMachine = (Integer) (session.getAttribute("machine_id"));
					ms.updateStatusMachine(idMachine, 0);
					ms.deleteConnection(idMachine, null);
					session.removeAttribute("machine_id");
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
			System.out.println("logout effettuato!");
			session.removeAttribute("user");
			session.invalidate();
			String address= "/index.jsp";
			request.getRequestDispatcher(address).forward(request, response);
		}
	}
		
		

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
