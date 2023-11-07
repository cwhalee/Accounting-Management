<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<style>
	.paging{
		display: flex;
    	justify-content: center;
	}
</style>

<script type="text/javascript">
function linkPage(pageNo){
	location.href = "${pageContext.request.contextPath}/account/accountList.do?pageNo="+pageNo;
}	
function excelDownload(){
	document.sendForm.action="${pageContext.request.contextPath}/account/excelDownload.do";
	document.sendForm.submit();
}

</script>

<form name="sendForm" id="sendForm" method="post" onsubmit="return false;">

<input type="hidden" id="situSeq" name="situSeq" value="">
<input type="hidden" id="mode" name="mode" value="Cre">

<div id="wrap"  class="col-md-offset-1 col-sm-10" >
		<div align="center"><h2>회계정보리스트</h2></div>
		<div class="form_box2 col-md-offset-7" align="right" >
			<div class="right" >
				<button class="btn btn-primary" onclick="location.href='/boardAjax/account/accountInsert.do'" >등록</button>
				<button class="btn btn-primary" onclick="excelDownload();">엑셀 다운</button>
			</div>
		</div>
	    <br/>
		<table class="table table-hover">
			    <thead>
			      <tr align="center">
			        <th style="text-align: center;" >수익/비용</th>
			        <th style="text-align: center;" >관</th>
			        <th style="text-align: center;" >항</th>
			        <th style="text-align: center;" >목</th>
			        <th style="text-align: center;" >과</th>
			        <th style="text-align: center;" >금액</th>
			        <th style="text-align: center;" >등록일</th>
			        <th style="text-align: center;" >작성자</th>
			      </tr>
			    </thead>
			    <tbody>
			   	<c:forEach items="${accountList}" var="var">
                <tr align="center">
                    <th style="text-align: center;" >${var.profitCost}</th>
                    <th style="text-align: center;" >${var.bigGroup}</th>
                    <th style="text-align: center;" >${var.middleGroup}</th>
                    <th style="text-align: center;" >
                    	<c:choose>
                    		<c:when test="${var.smallGroup eq null}">
                    			해당  없음
                    		</c:when>
                    		<c:otherwise>${var.smallGroup}</c:otherwise>
                    	</c:choose>
                    </th>
                    <th style="text-align: center;" >
                    	<c:choose>
                    		<c:when test="${var.detailGroup eq null}">
                    			해당  없음
                    		</c:when>
                    		<c:otherwise>${var.detailGroup}</c:otherwise>
                    	</c:choose>
                    </th>
                 	<th style="text-align: center;" ><fmt:formatNumber value="${var.transactionMoney}" type="number"/> 원</th>
                    <th style="text-align: center;" >
                    	<fmt:parseDate value="${var.regDate}" var="regDate" pattern="yyyy-mm-dd" scope="page"/>
						<fmt:formatDate value="${regDate}" pattern="yyyy.mm.dd" />
                    </th>
                    <th style="text-align: center;" ><a style="color: black;" href="/boardAjax/account/accountDetail.do?acc=${var.accountSeq}">${var.writer}</a></th>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
	<div class="paging">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
	</div>

</div>
</form>

<!-- <script type="text/javascript">
  var naver_id_login = new naver_id_login("_U8oSMhNbb6ycecPv1R3", "http://localhost:8080/boardAjax/login/naver.do");
  // 접근 토큰 값 출력
  alert(naver_id_login.oauthParams.access_token);
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
	  alert(naver_id_login.getProfileData('name'));
	  alert(naver_id_login.getProfileData('email'));	
	  alert(naver_id_login.getProfileData('age'));
  }
  
</script> -->
