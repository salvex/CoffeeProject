package com.coffee.util;

/* This class is needed to acquire the connection from DB. The JDBC API provides a set of classes (e.g: the DataSource) for communicating with DB 
 * 
 * the DataSource object is way more powerful and faster than the classic DriverManager way, so i'm using that
 */

import java.sql.*;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DBConnector {
	
	private DataSource dataSource; 
	
	public DBConnector() {
		try {
			dataSource = (DataSource) new InitialContext().lookup("java:comp/env/jdbc/coffedb");
		} catch (NamingException e) {
			throw new IllegalStateException("Database doesn't exist!");
		}
	}
	
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	
}
