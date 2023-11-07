<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="../js/common.js"></script><!-- Plugin -->

<script>
$(document).ready(function(){
	const data = {
			profitCost:("${result.profitCost}"),
			bigGroup:("${result.bigGroup}"),
			middleGroup:("${result.middleGroup}"),
			smallGroup:("${result.smallGroup}"),
			detailGroup:("${result.detailGroup}"),
			comments:("${result.comments}"),
			transactionMoney:("${result.transactionMoney}"),
			transactionDate:("${result.transactionDate}"),
			regDate:("${result.regDate}")
	};
	console.log(data);
	
	let stat = "A000000";
	$.ajax({
		url : "${pageContext.request.contextPath}/account/selectCombo.do",		
		type : "post",
		data : JSON.stringify({"category":stat}),
		contentType : "application/json",
		dataType : "JSON",
		success : function(value) {
			var arrayList = new Array();
			arrayList = value;
			console.log(arrayList)
			for(var i=0; i<arrayList.length; i++){
				var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
				$("#profitCost").append(option);
			}
			$("#profitCost").val(data.profitCost).prop("selected",true);
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	
	let profitCost = data.profitCost;
	$.ajax({
		url : "${pageContext.request.contextPath}/account/selectCombo.do",		
		type : "post",
		data : JSON.stringify({"category":profitCost}),
		contentType : "application/json",
		dataType : "JSON",
		success : function(value) {
			var arrayList = new Array();
			arrayList = value;
			console.log(arrayList)
			for(var i=0; i<arrayList.length; i++){
				var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
				$("#bigGroup").append(option);
			}
			$("#bigGroup").val(data.bigGroup).prop("selected",true);
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	let bigGroup = data.bigGroup;
	$.ajax({
		url : "${pageContext.request.contextPath}/account/selectCombo.do",		
		type : "post",
		data : JSON.stringify({"category":bigGroup}),
		contentType : "application/json",
		dataType : "JSON",
		success : function(value) {
			var arrayList = new Array();
			arrayList = value;
			console.log(arrayList)	
			for(var i=0; i<arrayList.length; i++){
				var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
				$("#middleGroup").append(option);
			}
			$("#middleGroup").val(data.middleGroup).prop("selected",true);
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	let middleGroup = data.middleGroup;
	$.ajax({
		url : "${pageContext.request.contextPath}/account/selectCombo.do",		
		type : "post",
		data : JSON.stringify({"category":middleGroup}),
		contentType : "application/json",
		dataType : "JSON",
		success : function(value) {
			var arrayList = new Array();
			arrayList = value;
			console.log(arrayList)	
			for(var i=0; i<arrayList.length; i++){
				var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
				$("#smallGroup").append(option);
			}
			$("#smallGroup").val(data.smallGroup).prop("selected",true);
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	let smallGroup = data.smallGroup;
	$.ajax({
		url : "${pageContext.request.contextPath}/account/selectCombo.do",		
		type : "post",
		data : JSON.stringify({"category":smallGroup}),
		contentType : "application/json",
		dataType : "JSON",
		success : function(value) {
			var arrayList = new Array();
			arrayList = value;
			console.log(arrayList)	
			for(var i=0; i<arrayList.length; i++){
				var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
				$("#detailGroup").append(option);
			}
			$("#detailGroup").val(data.detailGroup).prop("selected",true);
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
	});
	
	// 선택시 사용되는 Ajax
	$("#profitCost").on("change",function(){
		var category = $("#profitCost option:selected").val();
		
		$("#bigGroup option").remove();
		$("#bigGroup").append("<option>선택</option>");
		$("#middleGroup option").remove();
		$("#middleGroup").append("<option>선택</option>");
		$("#smallGroup option").remove();
		$("#smallGroup").append("<option>해당없음</option>");
		$("#detailGroup option").remove();
		$("#detailGroup").append("<option>해당없음</option>");

		$.ajax({
			url : "${pageContext.request.contextPath}/account/selectCombo.do",		
			type : "POST",
			data : JSON.stringify({"category":category}),
			contentType : "application/json",
			dataType : "JSON",
			success : function(value) {
				var arrayList = new Array();
				arrayList = value;
				console.log(arrayList)	
				
				for(var i=0; i<arrayList.length; i++){
					var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
					$("#bigGroup").append(option);
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	$("#bigGroup").on("change",function(){
		var category = $("#bigGroup option:selected").val();
		
		$("#middleGroup option").remove();
		$("#middleGroup").append("<option>선택</option>");
		$("#smallGroup option").remove();
		$("#smallGroup").append("<option>해당없음</option>");
		$("#detailGroup option").remove();
		$("#detailGroup").append("<option>해당없음</option>");
			
		$.ajax({
			url : "${pageContext.request.contextPath}/account/selectCombo.do",		
			type : "post",
			data : JSON.stringify({"category":category}),
			contentType : "application/json",
			dataType : "JSON",
			success : function(value) {
				var arrayList = new Array();
				arrayList = value;
				console.log(arrayList)	
				for(var i=0; i<arrayList.length; i++){
					var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
					$("#middleGroup").append(option);
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	$("#middleGroup").on("change",function(){
		var category = $("#middleGroup option:selected").val();
		
		$("#smallGroup option").remove();
		$("#smallGroup").append("<option>해당없음</option>");
		$("#detailGroup option").remove();
		$("#detailGroup").append("<option>해당없음</option>");
		
		$.ajax({
			url : "${pageContext.request.contextPath}/account/selectCombo.do",		
			type : "post",
			data : JSON.stringify({"category":category}),
			contentType : "application/json",
			dataType : "JSON",
			success : function(value) {
				var arrayList = new Array();
				arrayList = value;
				console.log(arrayList);
				for(var i=0; i<arrayList.length; i++){
					var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
					$("#smallGroup").append(option);
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
		
	$("#smallGroup").on("change",function(){
		var category = $("#smallGroup option:selected").val();
		
		$("#detailGroup option").remove();
		$("#detailGroup").append("<option>해당없음</option>");
		
		$.ajax({
			url : "${pageContext.request.contextPath}/account/selectCombo.do",		
			type : "post",
			data : JSON.stringify({"category":category}),
			contentType : "application/json",
			dataType : "JSON",
			success : function(value) {
				var arrayList = new Array();
				arrayList = value;
				console.log(arrayList);
				for(var i=0; i<arrayList.length; i++){
					var option = "<option value = '"+arrayList[i].code+"'>"+arrayList[i].comKor+"</option>"
					$("#detailGroup").append(option);
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	$("#accountUpdate").on("click",function(){
	
		var accountSeq = $("#accountSeq").val();;
		console.log(accountSeq);
		var profitCost = $("#profitCost").val();
		var bigGroup = $("#bigGroup").val();
		var middleGroup = $("#middleGroup").val();
		var smallGroup = $("#smallGroup").val();
		var detailGroup = $("#detailGroup").val();
		var comment = $("#comment").val();
		var transactionMoney = $("#transactionMoney").val();
		var transactionDate = $("#transactionDate").val();
		var writer = '${user.userId}';
		
		if(smallGroup == "해당없음"){
			var smallGroup = "";
		}
		if(detailGroup == "해당없음"){
			var detailGroup = "";
		}
		var accountVo = {
			accountSeq : accountSeq,
			writer : writer,
			profitCost : profitCost,
			bigGroup : bigGroup,
			middleGroup : middleGroup,
			smallGroup : smallGroup,
			detailGroup : detailGroup,
			comment : comment,
			transactionMoney : transactionMoney,
			transactionDate : transactionDate 
		}
		
		$.ajax({
			url : "${pageContext.request.contextPath}/account/accountUpdatePro.do",		
			type : "POST",
			data : JSON.stringify(accountVo),
			contentType : "application/json",
			dataType : "JSON",
			success : function(accountVo) {
				alert("수정 되었습니다.");
				location.href="${pageContext.request.contextPath}/account/accountDetail.do?acc="+acc;
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	$("#cancelBtn").on("click",function(){
		window.location.href = "${pageContext.request.contextPath}/account/accountList.do"
	});
	
	
}); 

</script>

<!-- 비용 START -->
<div class="container" style="margin-top: 50px">
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
	<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>

	<div class="col-sm-11" id="costDiv">
		<div>
			<input id="accountSeq" type="hidden" value="${param.acc}">
			<div class="col-sm-11">
				<div class="col-sm-12">
					<div class="col-sm-3">
						<select class="form-control" id="profitCost" name="profitCost"  title="비용">
				        	<option value="">선택</option>
				    		<c:forEach var="list" items="${resultMap}" varStatus="cnt">
					        	<option value="${list.code}">${list.comKor}</option>
				        	</c:forEach>
				        </select>
					</div>
					<div class="col-sm-3">
						<select class="form-control" id="bigGroup"  name="bigGroup" title="관">
				        	<option value="">선택</option>
				        </select>
				    </div>
					<div class="col-sm-3">
						<select class="form-control " id="middleGroup" name="middleGroup"  title="항">
					        <option value="">해당없음</option>
				        </select>
					</div>
				    <div class="col-sm-3">
						<select class="form-control "  id="smallGroup" name="smallGroup" title="목">
							<option value="">해당없음</option>
				        </select>
				    </div>
			 	</div>

			 	<div class="col-sm-12">  <label for="disabledInput" class="col-sm-12 control-label"> </label></div>
		 		<div class="col-sm-12">
		 			<div class="col-sm-3">
						<select class="form-control " id="detailGroup" name="detailGroup" title="과">
							<option value="">해당없음</option>
					    </select>
				    </div>
			      	<div class="col-sm-9">
			      		<input class="form-control " name="comment" id="comment" type="text" value="${result.comments}" placeholder="비용 상세 입력" title="비용 상세">
			      	</div>
		 		</div>
				<div class="col-sm-12">  <label for="disabledInput" class="col-sm-12 control-label"> </label></div>
			 	<div class="col-sm-12">
					<label for="disabledInput" class="col-sm-1 control-label"><font size="1px">금액</font></label>
				  	<div class="col-sm-3">
				  		<!--  
				  		oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
				  		input 태그에서 숫자만 입력되도록 정규식을 적용하고 숫자가 아닌게 입력되면 replace가 적용됨
				  		 -->
				    	<input class="form-control" id="transactionMoney" name="transactionMoney" type="number" value="${result.transactionMoney}" title="금액"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
				  	</div>
					<label for="disabledInput" class="col-sm-1 control-label"  ><font size="1px">거래일자</font></label>
				  	<div class="col-sm-3">
				  		
				   		<input class="form-contro col-sm-2 datepicker" id="transactionDate" name="transactionDate" type="text" value="<fmt:formatDate value="${result.transactionDate}" pattern="yyyy.MM.dd" />" style="width: 80%" title="거래일자">
				    </div>
				</div>
				<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
				<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
			</div>
		</div>
	</div>
</div>
<div style="margin-left: 700px;">
	<button type="button" id="accountUpdate" class="btn btn-primary">수정</button>
	<button type="button" id="cancelBtn" class="btn btn-warning">취소</button>
</div>

<!-- 비용 END -->

	