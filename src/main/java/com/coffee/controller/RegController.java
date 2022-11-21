package com.coffee.controller;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.coffee.model.User;
import com.coffee.model.UserService;
import com.coffee.util.SecurePassword;
import java.sql.*;
import org.json.*;

/**
 * Servlet implementation class RegController
 */
@WebServlet(urlPatterns = {"/RegController", "/Registration"})

public class RegController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String address= "/WEB-INF/view/Registration.jsp";
		request.getRequestDispatcher(address).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User userResult = new User();
		
		StringBuilder buffer = new StringBuilder();
		BufferedReader reader = request.getReader();
		String line;
		
		while((line = reader.readLine()) != null) {
			buffer.append(line);
		}
		
		String data = buffer.toString();
		JSONObject jsonReq = new JSONObject(data);
		
		String name= jsonReq.getString("name");
		String surname= jsonReq.getString("surname");
		String email = jsonReq.getString("email");
		String password= jsonReq.getString("password");
		String phone= jsonReq.getString("phone");
		
		UserService us = new UserService();
		
		try {
			userResult = us.findUserByEmail(email);
			if(userResult != null) {
				JSONObject Jlocation = new JSONObject();
				Jlocation.put("success", false);
				Jlocation.put("message", "Email already exists!");
				String location = Jlocation.toString();
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(location);
			} else {
				userResult = us.insertUser(name, surname, email, phone, password);
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
			}				
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		
	}

}
