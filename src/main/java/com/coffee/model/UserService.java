package com.coffee.model;

/* This is the class service, where the SQL query (CRUD operation) are implemented */

import java.sql.*;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.coffee.util.DBConnector;
import com.coffee.util.SecurePassword;

public class UserService {
	
	public UserService() {
		
	}
	
	public User findUserByEmail(String email) throws SQLException {
		User user=null;
				
		String findEmailString = "SELECT name, surname, email, phone, password, walletQnty FROM user WHERE email=?";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(findEmailString);
		) {
			statement.setString(1, email);
			
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					user = new User();
					user.setName(resultSet.getString("name"));
					user.setSurname(resultSet.getString("surname"));
					user.setEmail(resultSet.getString("email"));
					user.setPhone(resultSet.getString("phone"));
					user.setWallet(0,resultSet.getFloat("walletQnty"));
				}
			}
		}
		
		return user;
		
	}
		
	public User findUser(String email, String password) throws SQLException {
		User user = null;
		
		SecurePassword sp = new SecurePassword();
		sp.setPlainPassword(password);		
		String findString = "SELECT name, surname, email, phone, password, walletQnty FROM user WHERE email=?";
		
		DBConnector db = new DBConnector();
	
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(findString);	
		) {
			statement.setString(1, email);
			
			try (ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					if(sp.checkPassword(resultSet.getString("password")) == true ) {
						user = new User();
						user.setName(resultSet.getString("name"));
						user.setSurname(resultSet.getString("surname"));
						user.setEmail(resultSet.getString("email"));
						user.setPhone(resultSet.getString("phone"));
						user.setWallet(0,resultSet.getFloat("walletQnty"));
					} else {
						user = null;
					}
					
				}
			}
			
		}
		
		return user; 
	}
	
	public User insertUser(String name, String surname, String email, String phone, String password) throws SQLException {
		
		SecurePassword sp = new SecurePassword();
		sp.setPlainPassword(password);
		String cypherPass = sp.cryptPassword();
		
		
		User user = null;
		
		if(this.findUserByEmail(email) == null) {
					
			DBConnector db = new DBConnector();
			
			String insertString = "INSERT INTO user(name,surname,email,phone,password,walletQnty) VALUES(?,?,?,?,?,?)"; 
			
			try(
				Connection connection = db.getConnection();	
				PreparedStatement statement = connection.prepareStatement(insertString);
			) {
				statement.setString(1, name);
				statement.setString(2, surname);
				statement.setString(3, email);
				statement.setString(4, phone);
				statement.setString(5, cypherPass);
				statement.setFloat(6, 0);
				statement.executeUpdate();
				user = new User();
				user.setName(name);
				user.setSurname(surname);
				user.setEmail(email);
				user.setPhone(phone);
				user.setWallet(0, 0);
			}
		}
		
		return user;
	}
    
	public User updateWallet(User u, int opType, float wallet) throws SQLException {
		
		User userResult = null;
		
		
		String updateWalletString = "UPDATE user SET walletQnty=? WHERE email=?";
		
		DBConnector db = new DBConnector();
		
		try (
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(updateWalletString);
			
		) {
			switch(opType) {
				case 0: {
					u.setWallet(0, wallet);
					userResult = u;
					statement.setFloat(1, u.getWallet());
					statement.setString(2,u.getEmail());
					statement.executeUpdate();
					break;
				}
				case 1: {
					u.setWallet(1, wallet);
					userResult = u;
					statement.setFloat(1, u.getWallet());
					statement.setString(2,u.getEmail());
					statement.executeUpdate();
					break;
				}
				case 2: {
					u.setWallet(2, wallet);
					userResult = u;
					statement.setFloat(1, u.getWallet());
					statement.setString(2,u.getEmail());
					statement.executeUpdate();
					break;
				}
				default: break;
			}
		}
		
		return userResult;
	}
	
	

}
