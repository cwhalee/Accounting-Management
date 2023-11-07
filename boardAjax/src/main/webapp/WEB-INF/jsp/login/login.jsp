<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>


<script type="text/javascript">
	$(document).ready(function(){
		$("#signIn").on("click",function(){		
			var userId = $("#memId").val();
			var pwd = $("#memPassword").val();
			
			console.log(userId);
			console.log(pwd);
			
			var userVO = {
					userId: userId,
					pwd : pwd 
				}
			
			if(userId == null || userId == ''){
				alert("아이디를 입력해 주세요.")
				return false;
			}else if(pwd == null || pwd == ''){
				alert("비밀번호를 입력해주세요.")
				return false;
			}
			
			// 로그인
			$.ajax({
				url : "${pageContext.request.contextPath}/login/idCkedAjax.do",		
				type : "POST",
				data : JSON.stringify(userVO),
				contentType : "application/json",
				dataType : "json",
				success : function(result) {
					console.log(result);
					if(result == 1){
						console.log(result);
						alert("로그인 되었습니다.");
						window.location.href = "${pageContext.request.contextPath}/account/accountList.do"
					}else {
						alert("아이디 또는 비밀번호가 일치하지 않습니다.");
		                $('#memId').val('');
		                $('#memPassword').val('');
					}
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		});
		
	});
		
	
</script>

<form id="sendForm">

	<input type="hidden" id="platform" name="platform" value="">
	<div class="container col-md-offset-2 col-sm-6" style="margin-top: 100px;">
			<div class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				<input id="memId" type="text" class="form-control valiChk" name="memId" placeholder="id" title="ID">
			</div>
			<div class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				<input id="memPassword" type="password" class="form-control valiChk" name="memPassword" placeholder="Password" title="Password">
			</div>
			<br />
		<br>
		<div class="col-md-offset-4">
			<button type="button" id="signIn" class="btn btn-primary">로그인</button>
			<button type="button" id="#" class="btn btn-warning" onclick="location.href='/boardAjax/login/login.do'">취소</button>
			<button type="button" id="#" class="btn btn-info" onclick="location.href='/boardAjax/user/userInsert.do'">회원가입</button>
		</div>
		<!-- 네이버 로그인 버튼 노출 영역 -->
  		<div id="naver_id_login"></div>
	</div>
</form>
	
  
  <!-- //네이버 로그인 버튼 노출 영역 -->
  <script type="text/javascript">
  	var naver_id_login = new naver_id_login("_U8oSMhNbb6ycecPv1R3", "http://localhost:8080/boardAjax/login/naver.do");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("white", 2,40);
  	naver_id_login.setDomain("http://localhost:8080");
  	naver_id_login.setState(state);
  	//naver_id_login.setPopup(false); 이거쓰면 팝업창으로 로그인
  	naver_id_login.init_naver_id_login();
  	
  </script>

