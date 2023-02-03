package com.seedmall.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.user.mapper.MemberMapper;
import com.user.model.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper; 

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		
		log.warn("Load User By Email : " + email);
		
		MemberVO vo=memberMapper.read(email);
		
		log.warn("queried by member mapper: " + vo);
		
		return vo == null? null : new CustomUser(vo);
	}

}
