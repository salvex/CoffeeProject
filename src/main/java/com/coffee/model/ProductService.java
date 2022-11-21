package com.coffee.model;



import java.sql.*;

import com.coffee.util.DBConnector;


public class ProductService {
	
	public ProductService() {
		
	}
	
	public Product getProductById(int id) throws SQLException {
		Product p = null;
		
		String getProductQuery = "SELECT * FROM product WHERE idproduct=? ";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(getProductQuery);
		) {
			statement.setInt(1, id);
			
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					p = new Product();
					p.setId(resultSet.getInt("idproduct"));
					p.setDesc(resultSet.getString("desc"));
					p.setPrice(resultSet.getFloat("price"));
					p.setProductName(resultSet.getString("name"));
				}
			}
		}
			
		return p;
	}

}
