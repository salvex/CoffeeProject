package com.coffee.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import com.coffee.model.Machine;
import com.coffee.model.MachineService;
import com.coffee.model.User;
import com.coffee.model.UserService;

/**
 * Servlet implementation class UserController
 */
@WebServlet(urlPatterns = {"/UserController", "/User", "/User/Info", "/User/Credit", "/User/Connect", "/User/Disconnect"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address = null;
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		switch(uri) {
			case "/CoffeProject/User/Info": {
				address= "/WEB-INF/view/InfoView.jsp";
				System.out.println("sono dentro");
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
			case "/CoffeProject/User/Credit": {
				address= "/WEB-INF/view/CreditView.jsp";
				System.out.println("sono dentro 2");
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
			case "/CoffeProject/User/Connect": {
				address="/WEB-INF/view/ConnectView.jsp";
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
			default: {
				address= "/WEB-INF/view/UserView.jsp";
				request.getRequestDispatcher(address).forward(request, response);
				break;
			}
		}
		
		/*if(parameter == "1" && uri.endsWith("User")) {
			address= "/WEB-INF/view/InfoView.jsp";
			System.out.println("sono dentro");
			request.getServletContext().getRequestDispatcher(address).forward(request, response);
		} else {
			address= "/WEB-INF/view/UserView.jsp";
			request.getServletContext().getRequestDispatcher(address).forward(request, response);
		}*/ 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String address = null;
		
		User userSession = null;
		
		switch(uri) {
			case "/CoffeProject/User/Credit": {		
				StringBuilder buffer = new StringBuilder();
				BufferedReader reader = request.getReader();
				String line;
				
				while((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				
				String data = buffer.toString();
				JSONObject jsonReq = new JSONObject(data);
				String amountString = jsonReq.getString("amount");
				float amountFloat = Float.parseFloat(amountString);
				
				HttpSession session = request.getSession(false);	
				userSession = (User) session.getAttribute("user");
				
				UserService us = new UserService();
				
				try {
					User updatedUser = us.updateWallet(userSession, 1, amountFloat);
					session.removeAttribute("user");
					session.setAttribute("user", updatedUser);
					JSONObject Jres = new JSONObject();
					Jres.put("success", true);
					Jres.put("message", "Recharge Successfull!");
					String res = Jres.toString();
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(res);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;	
			}
			case "/CoffeProject/User/Connect": {
				StringBuilder buffer = new StringBuilder();
				BufferedReader reader = request.getReader();
				String line;
				
				while((line = reader.readLine()) != null) {
					buffer.append(line);
				}
				
				String data = buffer.toString();
				JSONObject jsonReq = new JSONObject(data);
				String IDS = jsonReq.getString("idMachine");
				int ID = Integer.parseInt(IDS);
				
				HttpSession session = request.getSession(false);
				
				User u = (User) session.getAttribute("user");
				
				String mail = u.getEmail();				
				MachineService ms = new MachineService();
				
				try {
					Machine machineReq=ms.findMachine(ID);
					
					//If the machine is not occupied and the current user is not connected to any machine, update the status flag in DB
					
					if(machineReq.getIsOccupied() == 0 && (session.getAttribute("machine_id") == null)) {
						ms.updateStatusMachine(ID, 1);
						machineReq.setOccupiedStatus(1);
						ms.addConnection(ID, mail);
						session.setAttribute("machine_id", machineReq.getIdMachine());
						JSONObject Jres = new JSONObject();
						Jres.put("type", "1");
						Jres.put("message", "Connected to Machine ID: " + ID + "!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
						
					//If the machine is occupied
						
					} else if(machineReq.getIsOccupied() == 1) {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "0");
						Jres.put("message", "Machine ID: " + ID + " occupied!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					
					//If the current user is already connected to machine (i'm using session)

				
					} else if(session.getAttribute("machine_id") != null) {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "-1");
						Jres.put("message", "You're already connected to a machine!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					
					//If the machine doesn't exist
						
					} else {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "-2");
						Jres.put("message", "The requested machine doesn't exist!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			}
			case "/CoffeProject/User/Disconnect": {
	
				
				HttpSession session = request.getSession(false);
				
				int IDMachineSession = (Integer) session.getAttribute("machine_id");
				
				MachineService ms = new MachineService();
				
				try {
					if(session.getAttribute("machine_id") != null) {
						userSession = ms.getConnectedUser(IDMachineSession);
						ms.deleteConnection(IDMachineSession, null);
						ms.updateStatusMachine(IDMachineSession, 0);
						session.removeAttribute("machine_id");
						session.removeAttribute("user");
						session.setAttribute("user", userSession);
						JSONObject Jres = new JSONObject();
						Jres.put("type", "1");
						Jres.put("message", "You've disconnected from Machine ID: " + IDMachineSession + "!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					} else {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "0");
						Jres.put("message", "You're not connected to any machine!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;	
			}
			default: {
				break;
			}
		}
		
	}

}
