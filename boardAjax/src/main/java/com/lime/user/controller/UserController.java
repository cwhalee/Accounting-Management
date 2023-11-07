package com.lime.user.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Calendar;
import java.util.Collections;

import javax.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.util.Utils;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lime.user.service.UserService;
import com.lime.user.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	//회원가입 폼
	@RequestMapping(value="/user/userInsert.do")
	public String userInsert() {
		return "/user/userInsert";
	}
	
	//id체크
	@ResponseBody
	@RequestMapping(value="/user/userIdCheck.do", method= {RequestMethod.POST})
	public int idCheck(@RequestBody UserVO userVo) {
		System.out.println("컨트롤러 유저 아이디는 : " + userVo.getUserId());
		
		int result = userService.idCheck(userVo);
		
		System.out.println("idcheck 컨트롤러" + result);
		
		return result;
	}
		
	//회원가입 
	@ResponseBody
	@RequestMapping(value="/user/userInsertPro.do", method= {RequestMethod.POST})
	public int userInsertPro(@RequestBody UserVO userVo) {
		System.out.println("controller:::::" + userVo);

		String psNum = userVo.getUserPsnum();
		String birthYear = psNum.substring(0, 2); 
		String genderCode = psNum.substring(6, 7); 
		int birthCentury = Integer.parseInt(birthYear);
		
		Calendar now = Calendar.getInstance();
		int currentYear = now.get(Calendar.YEAR);
		
		int age;
		if (birthCentury >= 0 && birthCentury <= 21) {
			age = currentYear - Integer.parseInt("20" + birthYear) + 1;
		} else {
			age = currentYear - Integer.parseInt("19" + birthYear) + 1;
		}

		String gender = "";
		if (genderCode.equals("1") || genderCode.equals("3")) {
		    gender = "남성";
		} else if (genderCode.equals("2") || genderCode.equals("4")) {
		    gender = "여성";
		} else {
		    gender = "알 수 없음";
		}

		userVo.setUserAge(age);
		userVo.setUserGender(gender);

		return userService.userInsert(userVo);
	}
	
	// E-mail 인증
	@ResponseBody
	@RequestMapping(value="/user/emailCheck.do", method = RequestMethod.GET)
	public String mailSending(String eMail) {
		return userService.checkMail(eMail);
	}
	
	// SMS 인증
    @ResponseBody
	@RequestMapping(value="/user/smsCheck.do", method = RequestMethod.GET)
    public String numbersend(String phoneNumber) throws Exception {
        return userService.checkSms(phoneNumber);
    }
    
}
