<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>aJaxTest2_2.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	$(function(){
    		$("#dodo").change(function(){
    			let dodo=$(this).val();
    			if(dodo=="") {
    				alert("지역을 선택하세요!");
    				return false;
    			}
    			
    			/* alert("선택한 지역? "+dodo); */
    			
    			$.ajax({
    				type: "post",
    				url: "${ctp}/study/ajax/aJaxTest2_2",
    				data: {dodo: dodo},
    				success: function(res) {
    					/* alert("res: "+res); */
    					
    					let str='';
    					
    					str+='<option value="">도시 선택</option>';
    					
    					for(let i=0; i<res.length; i++) {
    						if(res[i]==null) break;
    						str+='<option>'+res[i]+'</option>';
    					}
    					$("#city").html(str);
    					
    				},
    				error: function() {
    					alert("전송 오류!");
    				}
    			});
    		});
    	});
    	
    	function fCheck() {
    		let dodo=$("#dodo").val();
    		let city=$("#city").val();
    		
    		if(dodo=="" || city=="") {
    			alert("지역을 선택하세요!");
    			return false;
    		}
    		let str="선택하신 지역은? "+dodo+" / "+city+ "&nbsp;";
    		str+='<input type="button" value="다시 검색" onclick="location.reload()" class="btn btn-warning btn-sm" />';
    		$("#demo").html(str);
    		
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2>AJax를 활용한 값의 전달 2 (객체 배열 (ArrayList) 처리)</h2>
	<hr/>
	<form name="myform">
		<h3>도시를 선택하세요</h3>
		<select name="dodo" id="dodo">
			<option value="">지역 선택</option>
			<option value="서울">서울</option>
			<option value="경기">경기</option>
			<option value="충북">충북</option>
			<option value="충남">충남</option>
		</select>
		<select name="city" id="city">
			<option value="">도시 선택</option>		
		</select>
		<input type="button" value="선택" onclick="fCheck()" class="btn btn-primary" /> &nbsp; 
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/study/ajax/ajaxMenu';" class="btn btn-primary" />
	</form>
	
	<hr/>
	
	<div id="demo"></div>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>