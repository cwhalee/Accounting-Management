<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="../js/common.js"></script><!-- Plugin -->

<script>
$(document).ready(function(){
	
	$("#profitCost").on("change",function(){
		var category = $("#profitCost option:selected").val();
		var bigGroup = $("#bigGroup");
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
					bigGroup.append(option);
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
	$("#cancelBtn").on("click",function(){
		window.location.href = "${pageContext.request.contextPath}/account/accountList.do"
	});
	
	$("#accountInsert").on("click",function(){
		
		var profitCost = $("#profitCost").val();
		var bigGroup = $("#bigGroup").val();
		var middleGroup = $("#middleGroup").val();
		var smallGroup = $("#smallGroup").val();
		var detailGroup = $("#detailGroup").val();
		var comment = $("#comment").val();
		var transactionMoney = $("#transactionMoney").val();
		var transactionDate = $("#transactionDate").val();
		var writer = '${user.userId}';
		
		if (!profitCost || !bigGroup || !middleGroup || !transactionMoney || !transactionDate) {
	        alert("내용을 입력해주세요.");
	        return;
	    }
		
		if(smallGroup == "해당없음"){
			var smallGroup = "";
		}
		if(detailGroup == "해당없음"){
			var detailGroup = "";
		}
		
		var accountVo = {
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
			url : "${pageContext.request.contextPath}/account/accountInsertPro.do",		
			type : "POST",
			data : JSON.stringify(accountVo),
			contentType : "application/json",
			dataType : "JSON",
			success : function(acc) {
				console.log(acc);
				alert("등록 되었습니다.");
				location.href="${pageContext.request.contextPath}/account/accountDetail.do?acc="+acc;
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
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
			      		<input class="form-control " name="comment" id="comment" type="text" value="" placeholder="비용 상세 입력" title="비용 상세">
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
				    	<input class="form-control" id="transactionMoney" name="transactionMoney" type="number" value="" title="금액"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
				  	</div>
					<label for="disabledInput" class="col-sm-1 control-label"  ><font size="1px">거래일자</font></label>
				  	<div class="col-sm-3">
				   		<input class="form-contro col-sm-2 datepicker" id="transactionDate" name="transactionDate" type="text" value="" style="width: 80%" title="거래일자">
				    </div>
				</div>
				<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
				<div class="col-sm-12"><label for="disabledInput" class="col-sm-12 control-label"></label></div>
			</div>
		</div>
	</div>
</div>
<div style="margin-left: 700px;">
	<button type="button" id="accountInsert" class="btn btn-primary">등록</button>
	<button type="button" id="cancelBtn" class="btn btn-warning">취소</button>
</div>

<!-- 비용 END -->


<!-- 
<script>
$(document).ready(function() {
    const selectComboUrl = "${pageContext.request.contextPath}/account/selectCombo.do";
    const accountInsertUrl = "${pageContext.request.contextPath}/account/accountInsertPro.do";
   
    const profitCostSelect = $("#profitCost");
    const bigGroupSelect = $("#bigGroup");
    const middleGroupSelect = $("#middleGroup");
    const smallGroupSelect = $("#smallGroup");
    const detailGroupSelect = $("#detailGroup");
    const commentInput = $("#comment");
    const transactionMoneyInput = $("#transactionMoney");
    const transactionDateInput = $("#transactionDate");
    const cancelBtn = $("#cancelBtn");
    const accountInsertBtn = $("#accountInsert");

    // Function to populate dropdown options
    function populateDropdown(selectElement, data) {
        selectElement.empty();
        selectElement.append("<option>선택</option>");
        $.each(data, function(index, item) {
            selectElement.append(`<option value="${item.code}">${item.comKor}</option>`);
        });
    }

    // Event handler for profitCost dropdown change
    profitCostSelect.on("change", function() {
        const category = profitCostSelect.val();
        populateDropdown(bigGroupSelect, []);
        populateDropdown(middleGroupSelect, []);
        populateDropdown(smallGroupSelect, ["해당없음"]);
        populateDropdown(detailGroupSelect, ["해당없음"]);

        $.ajax({
            url: selectComboUrl,
            type: "POST",
            data: JSON.stringify({ "category": category }),
            contentType: "application/json",
            dataType: "JSON",
            success: function(data) {
                populateDropdown(bigGroupSelect, data);
            },
            error: function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    // Event handler for bigGroup dropdown change
    bigGroupSelect.on("change", function() {
        const category = bigGroupSelect.val();
        populateDropdown(middleGroupSelect, []);
        populateDropdown(smallGroupSelect, ["해당없음"]);
        populateDropdown(detailGroupSelect, ["해당없음"]);

        $.ajax({
            url: selectComboUrl,
            type: "post",
            data: JSON.stringify({ "category": category }),
            contentType: "application/json",
            dataType: "JSON",
            success: function(data) {
                populateDropdown(middleGroupSelect, data);
            },
            error: function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    // Event handler for middleGroup dropdown change
    middleGroupSelect.on("change", function() {
        const category = middleGroupSelect.val();
        populateDropdown(smallGroupSelect, ["해당없음"]);
        populateDropdown(detailGroupSelect, ["해당없음"]);

        $.ajax({
            url: selectComboUrl,
            type: "post",
            data: JSON.stringify({ "category": category }),
            contentType: "application/json",
            dataType: "JSON",
            success: function(data) {
                populateDropdown(smallGroupSelect, data);
            },
            error: function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    // Event handler for smallGroup dropdown change
    smallGroupSelect.on("change", function() {
        const category = smallGroupSelect.val();
        populateDropdown(detailGroupSelect, ["해당없음"]);

        $.ajax({
            url: selectComboUrl,
            type: "post",
            data: JSON.stringify({ "category": category }),
            contentType: "application/json",
            dataType: "JSON",
            success: function(data) {
                populateDropdown(detailGroupSelect, data);
            },
            error: function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    // Event handler for cancel button
    cancelBtn.on("click", function() {
        window.location.href = "${pageContext.request.contextPath}/account/accountList.do";
    });

    // Event handler for accountInsert button
    accountInsertBtn.on("click", function() {
        const profitCost = profitCostSelect.val();
        const bigGroup = bigGroupSelect.val();
        const middleGroup = middleGroupSelect.val();
        const smallGroup = smallGroupSelect.val() === "해당없음" ? "" : smallGroupSelect.val();
        const detailGroup = detailGroupSelect.val() === "해당없음" ? "" : detailGroupSelect.val();
        const comment = commentInput.val();
        const transactionMoney = transactionMoneyInput.val();
        const transactionDate = transactionDateInput.val();
        const writer = '${user.userId}';

        const accountVo = {
            writer: writer,
            profitCost: profitCost,
            bigGroup: bigGroup,
            middleGroup: middleGroup,
            smallGroup: smallGroup,
            detailGroup: detailGroup,
            comment: comment,
            transactionMoney: transactionMoney,
            transactionDate: transactionDate
        };

        $.ajax({
            url: accountInsertUrl,
            type: "POST",
            data: JSON.stringify(accountVo),
            contentType: "application/json",
            dataType: "JSON",
            success: function(acc) {
                console.log(acc);
                alert("등록 되었습니다.");
                location.href = "${pageContext.request.contextPath}/account/accountDetail.do?acc=" + acc;
            },
            error: function(XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });
});
</script>
 -->
	