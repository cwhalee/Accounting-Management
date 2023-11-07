<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
.form-control2{
	display: inline;
	width: 49%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>

<!-- 카카오 다음 우편번호 API 스크립트 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
    document.getElementById("memPlace1").addEventListener("click", function(){ 
        new daum.Postcode({
            oncomplete: function(data) { 
                document.getElementById("memPlace1").value = data.address; 
                document.querySelector("input[name=memPlace2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}
</script>

<!-- jQuery 스크립트 -->
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	// 변수 선언
    var isEmailVerified = false;
    var isCellVerified = false;
    var isUserIdChecked = false;
	
	var pattern1 = /[0-9]/;
	var pattern2 = /[a-zA-Z]/;
	var pattern3 = /[~!@#$%^&*<>*]/;
	var pattern4 = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	$("#idcked").on("click",function(){		
		var userId = $("#memId").val();
			
		var userVO = {
				userId: userId
		}
		
		if(userId == null || userId == ''){
			alert("아이디를 입력해 주세요.")
			return false;
		}else if(userId.length <= 5){
			alert("6글자 이상 입력해 주세요.")
			return false;
		}else if(!pattern2.test(userId)){
			alert("영문으로 입력해 주세요.")
			return false;
		}
		//ID 중복체크
		$.ajax({
			url : "${pageContext.request.contextPath}/user/userIdCheck.do",		
			type : "POST",
			data : JSON.stringify(userVO),
			contentType : "application/json",
			dataType : "json",
			success : function(result) {
				console.log(result);
				if(result == 0){
					isUserIdChecked = true;
	                checkActivation();
					alert("사용이 가능한 아이디 입니다.");
					$('#memId').prop('readonly',true);
				}else {
					alert("이미 사용중인 아이디 입니다.");
                    $('#memId').val('');
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	// 회원가입
	$("#saveBtn").on("click",function(){
		var userId = $("#memId").val();
		var pwd = $("#pwd").val();
		var pwdck = $("#pwdck").val();
		var userName = $("#memName").val();
		var userPsnum = $("#psNum1").val()+$("#psNum2").val();
		var userEmail = $("#eMail").val();
		var userCelnum = $("#userCell").val();
		var userPlace = $("#memPlace1").val()+$("#memPlace2").val;
		
		if(pwd.length <= 5 || pwd.length > 12){
			alert("비밀번호를 6 ~ 12글자로 입력해 주세요.");
		}else if(!pattern1.test(pwd)||!pattern2.test(pwd)||!pattern3.test(pwd)){
			alert("특수기호, 영문, 숫자를 조합해 주세요.");
		}else if(pwd != pwdck){
			alert("비밀번호가 일치하지 않습니다.");
		}else if(userName == null || userName == ''){
			alert("이름을 입력해 주세요.");
		}else if(userPsnum == null || userPsnum == ''){
			alert("주민등록번호를 입력해 주세요.");
		}else if(userEmail == null || userEmail == ''){
			alert("이메일을 입력해 주세요.");
		}else if(userCelnum == null || userCelnum == ''){
			alert("휴대폰번호를 입력해 주세요.");
		}else if($("#memPlace1").val() == null || $("#memPlace1").val() == ''){
			alert("주소를 입력해 주세요.");
		}else if($("#memPlace2").val() == null || $("#memPlace2").val() == ''){
			alert("상세주소를 입력해 주세요.");
		}else{
			var userVO = {
					userId: userId,
					pwd : pwd,
					userName : userName,
					userPsnum : userPsnum,
					userEmail : userEmail,
					userCelnum : userCelnum,
					userPlace : userPlace
			}			
			$.ajax({
				url : "${pageContext.request.contextPath}/user/userInsertPro.do",		
				type : "POST",
				data : JSON.stringify(userVO),
				contentType : "application/json",
				dataType : "json",
				success : function(result) {
					alert("가입 되었습니다.");
					window.location.href = "${pageContext.request.contextPath}/login/login.do"
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});
		}		
	});
	
	// E-Mail 인증 
	$('#eMailBtn').click(function() {
		const eMail = $('#eMail').val();
		const checkInput = $('#eMailChack')
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/user/emailCheck.do?eMail="+eMail, 
			success : function (data) {
				if(data == "falseMail"){
					alert("이미 가입되어있는 E-MAIL 입니다.");
				}else{
				checkInput.attr('disabled',false);
				mailcode = data;
				alert('인증번호가 전송되었습니다.');
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}			
		});
	});	
	// E-MAIL 인증번호 비교 
	$('#eMailChack').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#eMailResponse');
		
		if(inputCode === mailcode){
			isEmailVerified = true;
            checkActivation(); // 모든 검증이 완료되었는지 확인
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#eMailBtn').attr('disabled',true);
			$('#eMail').attr('readonly',true);
			$('#eMailChack').attr('readonly',true);
		}else{
			$resultMsg.html('인증번호가 불일치 합니다.');
			$resultMsg.css('color','red');
		}
	});
	
	// SMS 인증 
	$('#userCellBtn').click(function() {
		const userCell = $('#userCell').val();
		const checkInput = $('#userCellChack	')
		
		$.ajax({
			type : "GET",
			url : "${pageContext.request.contextPath}/user/smsCheck.do?phoneNumber="+userCell, 
			success : function (data) {
				if(data == "falseNum"){
					alert("이미 가입되어있는 번호 입니다.");
				}else{
				checkInput.attr('disabled',false);
				smscode = data;
				alert('인증번호가 전송되었습니다.');
				}
			}			
		});
	});
	// SMS 인증번호 비교 
	$('#userCellChack').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#smsResponse');
		
		if(inputCode === smscode){
			isCellVerified = true;
            checkActivation();
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#userCellBtn').attr('disabled',true);
			$('#userCell').attr('readonly',true);
			$('#userCellChack').attr('readonly',true);
		}else{
			$resultMsg.html('인증번호가 불일치 합니다.');
			$resultMsg.css('color','red');
		}
	});
	
	function checkActivation() {
        if (isUserIdChecked && isEmailVerified && isCellVerified) {
            $('#saveBtn').removeAttr("disabled");
        }
    }
	
});

</script>

<div class="container" style="margin-top: 50px">
	<form class="form-horizontal" id="sendForm">
		<div class="form-group">
			<label class="col-sm-2 control-label">ID</label>
			<div class="col-sm-4">
				<input class="form-control" id="memId" name="memId" type="text" value="" title="ID" required>
			</div>
	      	<div class="container">
	      		<button type="button" id="idcked" class="btn btn-default" style="display: block;">ID 중복 체크</button>
	      	</div>
		</div>

	    <div class="form-group">
			<label for="disabledInput " class="col-sm-2 control-label">패스워드</label>
			<div class="col-sm-4">
				<input class="form-control" id="pwd" name="" type="password" title="패스워드" required>
	      	</div>
	    </div>
	    
	    <div class="form-group">
	    	<label for="disabledInput " class="col-sm-2 control-label">패스워드 확인</label>
	      	<div class="col-sm-4">
	        	<input class="form-control" id="pwdck" name="" type="password" title="패스워드 확인" required>
	      	</div>
	    </div>

	    <div class="form-group">
	      	<label for="disabledInput" class="col-sm-2 control-label">이름</label>
	      	<div class="col-sm-4">
	        	<input class="form-control" id="memName" name="memName" type="text" value="" title="이름" required>
	      	</div>
	    </div>
	    
	    <div class="form-group">
	    	<label for="disabledInput " class="col-sm-2 control-label">주민등록번호</label>
	      	<div class="col-sm-4">
	        	<input class="form-control2" id="psNum1" name="psNum1" type="tel" maxlength="6" title="주민등록번호" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
	        	<input class="form-control2" id="psNum2" name="psNum2" type="password" maxlength="7" title="주민등록번호" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
	      	</div>
	    </div>
	    
	    <div class="form-group">
	      	<label for="disabledInput" class="col-sm-2 control-label">주소</label>
	      	<div class="col-sm-4">
	        	<input class="form-control" id="memPlace1" name="memPlace1" type="text" value="" title="주소" required>
	      	</div>
	    </div>
	    
		<div class="form-group">
	    	<label for="disabledInput" class="col-sm-2 control-label">상세주소</label>
	      	<div class="col-sm-4">
	        	<input class="form-control" id="memPlace2" name="memPlace2" type="text" value="" title="상세주소" required>
	      	</div>
	    </div>
	    
	    <div class="form-group">
			<label class="col-sm-2 control-label">E-MAIL</label>
			<div class="col-sm-4">
				<input class="form-control" id="eMail" name="eMail" type="text" value="" title="E-MAIL" required>
			</div>
	      	<div class="container">
	      		<button type="button" id="eMailBtn" class="btn btn-default" style="display: block;">E-MAIL</button>
	      	</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">E-MAIL 인증번호</label>
			<div class="col-sm-4">
				<input class="form-control" id="eMailChack" name="eMailChack" type="text" value="" title="eMailChack" required>
			</div>
			<div class="container">
				<span id="eMailResponse"></span>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">휴대폰번호</label>
			<div class="col-sm-4">
				<input class="form-control" id="userCell" name="userCell" type="text" value="" title="userCell" required>
			</div>
	      	<div class="container">
	      		<button type="button" id="userCellBtn" class="btn btn-default" style="display: block;">인증번호</button>
	      	</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">휴대폰 인증번호</label>
			<div class="col-sm-4">
				<input class="form-control" id="userCellChack" name="userCellChack" type="text" value="" title="userCellChack" required>
			</div>
			<div class="container">
				<span id="smsResponse"></span>
			</div>
		</div>
	    
	    <div class="col-md-offset-4" id="btnDiv">
			<button type="button" id="saveBtn"class="btn btn-primary" disabled>저장</button>
			<button type="button" id="#"class="btn btn-danger" onclick="location.href='/boardAjax/login/login.do'">취소</button>
	    </div>
	</form>
</div>