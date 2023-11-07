<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>




<script type="text/javascript">
  var naver_id_login = new naver_id_login("#", "http://localhost:8080/boardAjax/login/naver.do");
  // 접근 토큰 값 출력
  // alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	  console.log(naver_id_login.getProfileData('name'));
	  console.log(naver_id_login.getProfileData('email'));	
	  console.log(naver_id_login.getProfileData('age'));
	  
	  var userId = naver_id_login.getProfileData('name');
	  var pwd = naver_id_login.getProfileData('email');
	  
	  var userVO = {
				userId: userId,
				pwd : pwd 
			}
	  
	  $.ajax({
		    url: "${pageContext.request.contextPath}/login/naver2.do",
		    type: "POST",
		    data : JSON.stringify(userVO),
			contentType : "application/json",
			dataType : "json",
			success : function(result) {
				console.log(result);
				alert("로그인 되었습니다.");
				window.location.href = "${pageContext.request.contextPath}/account/accountList.do"
			},
			error : function() {
				console.log('실패');
			}
		  });
  }
  
</script>