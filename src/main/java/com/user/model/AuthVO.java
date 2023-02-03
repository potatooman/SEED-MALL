package com.user.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthVO {
	
	private int midx;
	private String email;
	private String auth;// 회원상태: ROLE_MEMBER 회원 ,ROLE_ADMIN 관리자
	
}
