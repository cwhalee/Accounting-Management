package com.lime.login.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import com.lime.login.service.LoginService;
import com.lime.common.service.CommonService;
import com.lime.user.vo.UserVO;



@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	@Resource(name = "jsonView")
	private MappingJackson2JsonView jsonView;

	@Resource(name="commonService")
	private CommonService commonService;

	@RequestMapping(value="/login/login.do")
	public String loginview(HttpServletRequest request ) {
		return "/login/login";
	}

	@ResponseBody
	@RequestMapping(value="/login/idCkedAjax.do", method= {RequestMethod.POST})
	public int login(@RequestBody UserVO userVo, HttpSession session) {
		int result = loginService.login(userVo);

		if(result != 0) {
			session.setAttribute("user", userVo);
		}
		return result;
	}
	
	
	//logout
	@RequestMapping(value="/login/logout.do")
	public String logout(HttpSession session) {
		
		//세션의 값 삭제
		session.removeAttribute("user");
		session.invalidate();
		return "redirect:/login/login.do";
	}
	
	// 네이버 로그인
	@RequestMapping(value="/login/naver.do", method= {RequestMethod.GET})
	public String loginNaver(HttpServletRequest request, HttpSession session) {
		return "/login/login2";
	}
	
	@ResponseBody
	@RequestMapping(value="/login/naver2.do", method= {RequestMethod.POST})
	public int loginNaver2(@RequestBody UserVO userVo, HttpSession session) {
		System.out.println("컨트롤러 확인용                                  "+userVo.getUserId());
		
		int result = 1;
		session.setAttribute("user", userVo);
		return result;
	}
}
