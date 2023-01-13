<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>uuidForm.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	let str="";
    	let cnt=0;
    	function uuidCheck() {
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/uuid/uuidProcess",
    			success: function(res) {
    				cnt++;
    				str += cnt+" : "+res+"<br/>";
    				$("#demo").html(str);
    			},
    			error: function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2>UUID에 대하여</h2>
	<p>
		UUID (Univerally Unique Indentifier)란, 네트워크 상에서 고유성이 보장되는 ID를 만들기 위한 규약 <br/>
		32자리의 16진수(128Bit)로 표현된다. <br/>
		표시 : 8-4-4-4-12 자리로 표현
		예 : 55e8400e-f123-ds34-a124-dj24jfj6ndj3
	</p>
	<p>
		<input type="button" value="UUID 생성" onclick="uuidCheck()" class="btn btn-primary" />
		<input type="button" value="다시 하기" onclick="location.reload()" class="btn btn-secondary" /> 
	</p>
	<hr/>
	<div>
		출력결과 <br/>
		<span id="demo"></span>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>