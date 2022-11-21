package com.coffee.model;

import java.sql.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.coffee.util.DBConnector;

public class MachineService {
	
	public MachineService() {
		
	}
	
	/*public Machine getMachine() {
		
	}*/
	
	public Machine findMachine(int idMachine) throws SQLException {
		Machine m = null;
		
		String findMachineQuery = "SELECT * FROM machine WHERE idmachine=? ";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(findMachineQuery);
		) {
			statement.setInt(1, idMachine);
			
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					m = new Machine();
					m.setIdMachine(idMachine);
					m.setBrandName(resultSet.getString("brand"));
					if(this.findProductsAssociatedToMachine(idMachine) != null) {
						m.setProductListWithPrices(this.findProductsAssociatedToMachine(idMachine));
					} else {
						m.setProductListWithPrices(null);
					}
					m.setOccupiedStatus(resultSet.getInt("isOccupied"));	
				}
			}
		}
			
		return m;
	}
	
	public void addConnection(int idMachine, String usermail) throws SQLException {
		
		String addConnectionQuery = "INSERT INTO connection(ref_email,ref_machine) VALUES(?,?)";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(addConnectionQuery);
		) {
			statement.setString(1, usermail);
			statement.setInt(2, idMachine);
			statement.executeUpdate();
		}
	}
	
	public void deleteConnection(int idMachine, String usermail) throws SQLException {
		String addConnectionQuery = "DELETE FROM connection WHERE ref_email=? OR ref_machine=?";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(addConnectionQuery);
		) {
			statement.setString(1, usermail);
			statement.setInt(2, idMachine);
			statement.executeUpdate();
		}
	}
	
	public void updateProductQuantity(int idMachine, int idProduct) throws SQLException {
		String updateProductQuantityQuery = "UPDATE availability SET qntY = qntY - 1 WHERE ref_machine=? AND ref_product=?";
		
		DBConnector db = new DBConnector();
		
		try (
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(updateProductQuantityQuery);
		) {
			statement.setInt(1, idMachine);
			statement.setInt(2, idProduct);
			statement.executeUpdate();
		}
		
	}
	
	//getProductQuantity
	//updateProductQuantity
	public int getProductQuantity(int idMachine, int idProduct) throws SQLException {
		String getProductQuery = "SELECT availability.qntY FROM availability WHERE ref_machine=? AND ref_product=?";
		
		int qnty  = 0;
		
		DBConnector db = new DBConnector();
		
		try (
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(getProductQuery);
		) {
			statement.setInt(1, idMachine);
			statement.setInt(2, idProduct);
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					qnty = resultSet.getInt("qntY");
				}
			}
		}
		return qnty;	
		
	}
	
	public User getConnectedUser(int idMachine) throws SQLException{
		
		User u=null;
		
		String findConnectionQuery = "SELECT ref_email FROM connection WHERE ref_machine=?";
		
		
		DBConnector db = new DBConnector();
		
		try (
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(findConnectionQuery);
		) {
			statement.setInt(1, idMachine);
				
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					UserService us = new UserService();
					u=us.findUserByEmail(resultSet.getString("ref_email"));
				}
			}
		}
		
		return u;
	}
	
	
	
	
	public void updateStatusMachine(int idMachine,int status) throws SQLException {
		Machine m = null;
		
		String updateStatusQuery = "UPDATE machine SET isOccupied=? WHERE idmachine=?";
		
		m=this.findMachine(idMachine);
		
		if(m != null) {
			DBConnector db = new DBConnector();
			try(
					Connection connection = db.getConnection();
					PreparedStatement statement = connection.prepareStatement(updateStatusQuery);	
				) {
					statement.setInt(1, status);
					statement.setInt(2, idMachine);
					statement.executeUpdate();
				
			}
		}
		
	}
	
	public TreeMap<Product, Integer> findProductsAssociatedToMachine(int idMachine) throws SQLException {
		
		Map<Product, Integer> m = new HashMap<Product, Integer>();
		TreeMap<Product, Integer> mSorted = null;
		
		String findProductQuery = "SELECT product.*, availability.qntY FROM product,availability,machine WHERE machine.idmachine=? AND availability.ref_machine=machine.idmachine AND availability.ref_product=product.idproduct";
		
		DBConnector db = new DBConnector();
		
		try(
			Connection connection = db.getConnection();
			PreparedStatement statement = connection.prepareStatement(findProductQuery);
		) {
			statement.setInt(1, idMachine);
			
			try(ResultSet resultSet = statement.executeQuery()) {
				if(resultSet.next()) {
					do {
						Product p = new Product();
						p.setId(resultSet.getInt("idproduct"));
						p.setProductName(resultSet.getString("name"));
						p.setPrice(resultSet.getFloat("price"));
						p.setDesc(resultSet.getString("desc"));
						m.put(p,resultSet.getInt("qntY"));
					} while(resultSet.next());
				} else {
					m = null;
				}
			}
		}
		
		if(m != null) {
			mSorted = new TreeMap<>(m);
		}
		
		return mSorted;
	}
	
	
}	
