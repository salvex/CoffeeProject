package com.coffee.model;
import java.util.HashMap;
import java.util.TreeMap;


public class Machine {
	private int idMachine;
	private int isOccupied;
	private String brandName;
	private TreeMap<Product,Integer> productListWithPrices;
	
	public Machine() {
		
	}
	
	public int getIdMachine() {
		return this.idMachine;
	}
	
	public String getBrandName() {
		return this.brandName;
	}
	
	public int getIsOccupied() {
		return this.isOccupied;
	}
	
	public TreeMap<Product,Integer> getProductListWithPrices() {
		return this.productListWithPrices;
	}
	
	public void setIdMachine(int id) {
		this.idMachine = id;
	}
	
	public void setBrandName(String name) {
		this.brandName = name;
	}
	
	public void setProductListWithPrices(TreeMap<Product,Integer> products) {
		this.productListWithPrices = products;
	}
	
	public void setOccupiedStatus(int occ) {
		this.isOccupied = occ;
	}
} 
