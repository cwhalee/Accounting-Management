package com.lime.login.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lime.user.vo.UserVO;

@Service
public class LoginService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int login(UserVO userVo) {
		return sqlSessionTemplate.selectOne("Login.selectUserLogin", userVo);
	}
	
}