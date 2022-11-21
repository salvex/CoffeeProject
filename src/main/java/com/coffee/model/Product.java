package com.coffee.model;

public class Product implements Comparable<Product> {
	private int id;
	private String productName;
	private float price;
	private String desc;
	
	public Product() {
		
	}
	
	public void setId(int id) {
		this.id=id;
	}
	
	public void setProductName(String name) {
		this.productName = name;
	}
	
	public void setPrice(float price) {
		this.price = price;
	}
	
	public void setDesc(String desc) {
		this.desc = desc;
	}
	

	public int getId() {
		return this.id;
	}
	
	
	public String getProductName() {
		return this.productName;
	}
	
	public float getPrice() {
		return this.price;
	}
	
	public String getDesc() {
		return this.desc;
	}
	
	public String toString() {
		return "Product ID: " + this.id;
	}
	
	@Override
	public int compareTo(Product p) {
		return (this.id > p.getId()) ? 1 : ((this.id == p.getId()) ? 0 : -1);
	}
	
}
