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
import com.coffee.model.User;
import com.coffee.model.UserService;
import com.coffee.util.SecurePassword;


/**
 * Servlet implementation class LoginController
 */
@WebServlet(urlPatterns = {"/LoginController", "/Login"})

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String address= "/WEB-INF/view/Login.jsp";
		request.getRequestDispatcher(address).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		User userResult = new User();
		
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		
		while((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		
		String data = buffer.toString();
		JSONObject jsonReq = new JSONObject(data);
		
		String email = jsonReq.getString("email");
		String password = jsonReq.getString("password");
		UserService us = new UserService();
		
		try {
			userResult = us.findUser(email, password);
			if(userResult != null) {
				HttpSession session = request.getSession(true);
				session.setMaxInactiveInterval(60*15);
				session.setAttribute("user", userResult);
				JSONObject Jlocation = new JSONObject();
				Jlocation.put("success", true);
				Jlocation.put("address", "/CoffeProject/User");
				String location = Jlocation.toString();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(location);
			} else {
				JSONObject Jlocation = new JSONObject();
				Jlocation.put("success", false);
				Jlocation.put("message", "Your email or password is not correct!");
				String location = Jlocation.toString();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(location);
			}
		} catch(SQLException  | IllegalArgumentException e) {
			e.printStackTrace();
			JSONObject Jlocation = new JSONObject();
			Jlocation.put("success", false);
			Jlocation.put("message", "Your email or password is not correct!");
			String location = Jlocation.toString();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(location);
		}
		
		
	}

}
