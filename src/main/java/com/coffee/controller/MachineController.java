package com.coffee.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.coffee.model.Machine;
import com.coffee.model.MachineService;
import com.coffee.model.Product;
import com.coffee.model.ProductService;
import com.coffee.model.User;
import com.coffee.model.UserService;

/**
 * Servlet implementation class MachineController
 */
@WebServlet({ "/MachineController", "/Machine", "/Machine/Update", "/Machine/Buy" })
public class MachineController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MachineController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String machineID = request.getParameter("id");
	
		MachineService ms = new MachineService();
		try {
			Machine requestMachine = ms.findMachine(Integer.parseInt(machineID));
			if(requestMachine != null) {
				request.setAttribute("machine", requestMachine);
				String address= "/WEB-INF/view/MachineView.jsp";
				request.getRequestDispatcher(address).forward(request, response);
			} else {
				String address = "/404error.jsp";
				request.getRequestDispatcher(address).forward(request, response);
			}
		} catch (SQLException e) {
				e.printStackTrace();
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
		String uri = request.getRequestURI();
		String address = "/WEB-INF/view/MachineView.jsp";
		User user = null; 
		Machine m = null;
		Product p = null;
		
		switch (uri) {
			case "/CoffeProject/Machine/Update": {
				try {
					StringBuilder buffer = new StringBuilder();
					BufferedReader reader = request.getReader();
					String line;
					
					while((line = reader.readLine()) != null) {
						buffer.append(line);
					}
					
					String data = buffer.toString();
					JSONObject jsonReq = new JSONObject(data);
					int id = Integer.parseInt(jsonReq.getString("idMachine"));
					int currentOccupation = Integer.parseInt(jsonReq.getString("isOccupied"));
					MachineService ms = new MachineService();
					
					user=ms.getConnectedUser(id);
					m=ms.findMachine(id);
					//if the user is in the connection table, current machine is occupied and current occupation is the same as DB occupation, do nothing
					if(user != null && currentOccupation == 1 && currentOccupation == m.getIsOccupied()) {
						request.getRequestDispatcher(address).forward(request, response);
					//if the user isn't in the connection table, current machine is occupied and current occupation is different from DB occupation, update request machine and send it back
					} else if(user == null && currentOccupation == 1 && currentOccupation != m.getIsOccupied()) {
						m.setOccupiedStatus(0);
						request.setAttribute("machine", m);
						request.getRequestDispatcher(address).forward(request, response);
					//if the user isn't in the connection table, current machine isn't occupied and current occupation is the same as DB occupation, do nothing
					} else if(user == null && currentOccupation == 0 && currentOccupation == m.getIsOccupied()) {
						request.getRequestDispatcher(address).forward(request, response);
					//if the user is in the connection table, current machine isn't occupied and current occupation is different from DB occupation, update current machine and send user data to allow buying products
					} else if(user != null && currentOccupation == 0 && currentOccupation != m.getIsOccupied()) {
						m.setOccupiedStatus(1);
						request.setAttribute("machine", m);
						request.setAttribute("user", user);
						request.getRequestDispatcher(address).forward(request, response);
					}	
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			}
			case "/CoffeProject/Machine/Buy": {
				try {
					
					
					StringBuilder buffer = new StringBuilder();
					BufferedReader reader = request.getReader();
					String line;
					
					while((line = reader.readLine()) != null) {
						buffer.append(line);
					}
					
					String data = buffer.toString();
					JSONObject jsonReq = new JSONObject(data);
					
					int idMachine = Integer.parseInt(jsonReq.getString("idMachine"));
					int selection = Integer.parseInt(jsonReq.getString("selection"));
					
					MachineService ms = new MachineService();
					ProductService ps = new ProductService();
					
					user=ms.getConnectedUser(idMachine);
					p=ps.getProductById(selection);
					
					if (p == null) {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "-2");
						Jres.put("message", "This product doesn't exist!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);					
					} else if(ms.getProductQuantity(idMachine, selection) == 0) {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "-1");
						Jres.put("message", "This product is not available!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					} else if(user.getWallet() == 0 || (p.getPrice() > user.getWallet())) {
						JSONObject Jres = new JSONObject();
						Jres.put("type", "0");
						Jres.put("message", "You don't have enough money!");
						String res = Jres.toString();
						response.setContentType("application/json");
						response.setCharacterEncoding("UTF-8");
						response.getWriter().write(res);
					} else {
						UserService us = new UserService();
						us.updateWallet(user, 2, p.getPrice());
						ms.updateProductQuantity(idMachine, selection);
						JSONObject Jres = new JSONObject();
						Jres.put("type", "1");
						Jres.put("message", "You've bought Product ID " + p.getId() + " with success!");
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
		}
	
	}

}
