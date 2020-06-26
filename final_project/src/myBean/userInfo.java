package myBean;

import java.util.*;

public class userInfo {
	private String userId;
	private String userPass;
	private String birthday;
	
	public void setUserId(String userId) {
		this.userId=userId;
	}
	
	public void setUserPass(String userPass) {
		this.userPass=userPass;
	}
	
	public void setBirthday(String birthday) {
		this.birthday=birthday;
	}
	
	public String getBirthday() {
		return birthday;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public String getUserPass() {
		return userPass;
	}
	
	public int getAge() {
		int birthAge=-1;
		try {
			birthAge=Integer.parseInt(birthday.substring(0,4));
		}catch(Exception e) {
			return birthAge;
		}
		Calendar calendar=Calendar.getInstance();
		int thisAge=calendar.get(Calendar.YEAR);
		return thisAge-birthAge+1;
	}
}
