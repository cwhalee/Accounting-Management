package com.lime.user.service;

import org.json.*;
import java.util.Base64;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import okhttp3.*;

import java.util.Random;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.lime.user.vo.UserVO;

@Service
public class UserService {
	
	private SqlSessionTemplate sqlSessionTemplate;
	private JavaMailSender mailSender;
	
	public UserService() {};
	
	@Autowired
	public UserService(SqlSessionTemplate sqlSessionTemplate, JavaMailSender mailSender) {
		this.sqlSessionTemplate = sqlSessionTemplate;
		this.mailSender = mailSender;
	};
	
	// 이메일 인증번호 사용
	private int authNumber; 
	
	// SMS 인증 사용
	private static String projectId = "#";
    private static String accessKey = "#";
    private static String secretKey = "#";

    private static String url = "/sms/v2/services/"+projectId+"/messages";
    private static String requestUrl = "https://sens.apigw.ntruss.com"+url;

    private static String timestamp = Long.toString(System.currentTimeMillis()); 
    private static String method = "POST";
	
	
	//id체크
	public int idCheck(UserVO userVo) {		
		int result = sqlSessionTemplate.selectOne("Login.idCheck", userVo);	
		return result;
	}
	
	//회원가입
	public int userInsert(UserVO userVo) {
		return sqlSessionTemplate.insert("Login.userInsert", userVo);
	}
	
	// 인증번호 난수
	public void makeRandomNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}
	
	//이메일 양식
	public String checkMail(String eMail) {
	    int result = sqlSessionTemplate.selectOne("Login.emailCheck", eMail);
	    
	    if (result == 1) {
	        // 이미 존재하는 이메일로 판단되어 컨트롤러로 리턴
	        return "falseMail"; 
	    } else {
	        makeRandomNumber();
	        String setFrom = "koomga00@gmail.com"; 
	        String toMail = eMail;
	        String title = "회원 가입 인증 이메일 입니다."; 
	        String content = 
	                "인증 번호는 " + authNumber + "입니다." + 
	                "<br>" + 
	                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
	        mailSend(setFrom, toMail, title, content);
	        return Integer.toString(authNumber);
	    }
	}
	
	//이메일 전송 
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		System.out.println(setFrom + toMail + title + content);
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
    // E-MAIL 인증 END
	
	// SMS 인증
    public String checkSms(String phoneNumber) throws Exception {
    	int result = sqlSessionTemplate.selectOne("Login.cellCheck", phoneNumber);
    	
    	if (result == 1) {
	        // 이미 존재하는 이메일로 판단되어 컨트롤러로 리턴
	        return "falseNum"; 
	    } else {
	    	JSONObject bodytJson = new JSONObject();
	        JSONObject toJson = new JSONObject();
	        JSONArray toArr = new JSONArray();
	        
	        String testnumber = "" + (int)(Math.random()*10) + (int)(Math.random()*10) + (int)(Math.random()*10) + (int)(Math.random()*10) + (int)(Math.random()*10) + (int)(Math.random()*10);
	        String content = "인증번호["+ testnumber +"]를 입력해주세요.";
	        String subject = "회원가입 인증 번호 입니다.";
	        toJson.put("subject" , subject);
	        toJson.put("content" , content);
	        toJson.put("to" , phoneNumber);
	        toArr.put(toJson);
	
	        bodytJson.put("type" , "SMS");
	        bodytJson.put("contentType" , "COMM");
	        bodytJson.put("countryCode" , "82");
	        bodytJson.put("from" , "01055746222");
	        bodytJson.put("subject" , "제목");
	        bodytJson.put("content" , "내용");
	        bodytJson.put("messages" , toArr );
	        String body = bodytJson.toString();
	        String result2 = doPost(requestUrl , body);
	        System.out.println(result2);
	        return testnumber;
	    }
    }

    // OkHttp 통신
    public String doPost(String requestURL , String jsonMessage) throws Exception {
    	OkHttpClient client = new OkHttpClient();
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/json"), jsonMessage);

        Request request = new Request.Builder()
                .addHeader("x-ncp-apigw-timestamp", timestamp)
                .addHeader("x-ncp-iam-access-key", accessKey)
                .addHeader("x-ncp-apigw-signature-v2", makeSignature())
                .url(requestURL)
                .post(requestBody)
                .build();

        Response response = client.newCall(request).execute();
        // 출력
        String message = response.body().string();
        return message;
    };

    // Signature생성
    public String makeSignature() throws Exception {
        String space = " ";        // one space
        String newLine = "\n";    // new line
        String message = new StringBuilder()
            .append(method)
            .append(space)
            .append(url)
            .append(newLine)
            .append(timestamp)
            .append(newLine)
            .append(accessKey)
            .toString();
        
        String encodeBase64String = null;
        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey);

        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
        encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

      return encodeBase64String;
    };
    // SMS 인증 END
    

}
