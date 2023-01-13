<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ajaxMenu.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function aJaxTest1_1(idx) {
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/ajax/ajaxTest1_1",
    			data: {idx: idx},
    			success: function(res) {
    				$("#demo").html(res);
    			},
    			error: function() {
    				alert("전송 오류!!!");
    			}
    		});
    	}
    	
    	function aJaxTest1_2(idx) {
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/ajax/ajaxTest1_2",
    			data: {idx: idx},
    			success: function(res) {
    				$("#demo").html(res);
    			},
    			error: function() {
    				alert("전송 오류!!!");
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
	<h2>aJax 연습</h2>
	<hr/>
	<p>기본 (String): 
		<a href="javascript:aJaxTest1_1(10)" class="btn btn-secondary">값 전달 1</a> &nbsp;
		<a href="javascript:aJaxTest1_2(10)" class="btn btn-secondary">값 전달 2</a> &nbsp;
		= <span id="demo"></span>
	</p>
	
	<p>응용 1 (일반 배열): 
		<a href="${ctp}/study/ajax/aJaxTest2_1" class="btn btn-primary">시(도) / 구(시,군,동) / String 형태 배열</a> &nbsp;
		<a href="${ctp}/study/ajax/aJaxTest2_2" class="btn btn-primary">시(도) / 구(시,군,동) / ArrayList 형태 배열</a> &nbsp;
		<a href="${ctp}/study/ajax/aJaxTest2_3" class="btn btn-primary">시(도) / 구(시,군,동) / Map(HashMap<k,v>) 형태 배열</a> &nbsp;
		= <span id="demo"></span>
	</p>
	
	<p>응용 2 (DB 자료 추출): 
		<a href="${ctp}/study/ajax/aJaxTest3" class="btn btn-primary">회원 아이디 검색 (DB 활용)</a> &nbsp;
	</p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>