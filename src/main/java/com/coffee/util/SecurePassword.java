package com.coffee.util;
import com.lambdaworks.*;
import com.lambdaworks.crypto.SCryptUtil;



public class SecurePassword {
	
	private String plainPassword;
	
	public SecurePassword() {
		this.plainPassword = null;
	}
	
	public void setPlainPassword(String newplainP) {
		this.plainPassword = newplainP;
	}
	
	public String getPlainPassword() {
		return this.plainPassword;
	}
	
	public String cryptPassword() {
		return SCryptUtil.scrypt(this.plainPassword, 16, 16 , 16); 
	}
	
	public boolean checkPassword(String cypherPassword) {
		return SCryptUtil.check(this.plainPassword,cypherPassword);
	}
	
}
