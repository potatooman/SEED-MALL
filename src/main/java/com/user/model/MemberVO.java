package com.user.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MemberVO {
	
	
	private int midx;
	private String email;
	private String pwd;
	private String mname;
	private String mhp1,mhp2,mhp3;
	private String mpost;
	private String maddr1, maddr2;
	private String grade;
	private int enabled; // 1=활성 0=비활성
	private String statusStr;
	private java.sql.Date mdate;
	private int mileage;
	private String auth; 
	private List<AuthVO> authList;
	
	public String getAllHp() {
		return mhp1+"-"+mhp2+"-"+mhp3;
	}
	
	public String getAllAddr() {
		return maddr1+" "+maddr2;
	}
}////