/* In MVC Pattern, the Java Bean can be mapped into a Model
 * . The User Bean contains the necessary for distinguishing every different User 
 * and 'attach the bean' to an effective user's session */


package com.coffee.model;

public class User {
	private String name;
	private String surname;
	private float wallet;
	private String phone;
	private String email;
	
	
	public User() {
		//void constructor, according to Java Bean good practices
	}
	
	public void setName(String newname) {
		this.name = newname;
	}
	
	public void setSurname(String newsurname) {
		this.surname = newsurname;
	}
	
	public void setWallet(int opType, float newmoney) {
		if(opType == 1) {
			this.wallet += newmoney;
		} else if(opType == 0) {
			this.wallet = newmoney;
		} else if(opType == 2 && this.wallet > newmoney) {
			this.wallet -= newmoney;
		}
	}
	
	public void setPhone(String phonenum) {
		this.phone=phonenum;
	}
	
	public void setEmail(String emailaddr) {
		this.email=emailaddr;
	}

	public String getName() {
		return this.name;
	}
	
	public String getSurname() {
		return this.surname;
	}
	
	public float getWallet() {
		return this.wallet;
	}
	
	public String getPhone() {
		return this.phone;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	@Override
	public String toString() {
		return "Nome: " + this.name + "\n" + "Cognome: " + this.surname;
	}
} 
