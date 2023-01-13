<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>aria.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	let cnt=0;
    	
    	function ariaCheck() {
    		let pwd=document.getElementById("pwd").value;
    		
    		$.ajax({
				type: "post",
				url: "${ctp}/study/password/aria",
				data: {pwd:pwd},
				success: function(res) {
					cnt++;
					$("#demo").append(cnt+". "+res);
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
	<h2>ARIA 암호화</h2>
	<p>
		ARIA 암호화 방식은 경량 환경 및 하드웨어 구현을 위해 최적화된, Involutional SPN 구조를 갖는 범용 블록 암호화 알고리즘이다. <br/>
		ARIA가 사용하는 연산은 대부분 XOR 과 같은 단순한 바이트 단위 연산으로, 블록 크기는 128bit이다.  <br/>
		ARIA는 Academy (학계), Reearch Institute (연구소), Agency (정부기관)의 첫글자를 따서 만들었다! <br/>
		그래서 ARIA 개발에 참여한 '학/연/관'의 공동 노력을 포함한다. <br/>
		ARIA 암호화는 복호화가 가능하다.
	</p>
	
	<hr/>
	
	<p>
		<input type="text" name="pwd" id="pwd" autofocus />
		<input type="button" value="ARIA 암호화" onclick="ariaCheck()" class="btn btn-secondary" />
		<input type="button" value="다시하기" onclick="location.reload()" class="btn btn-secondary" />
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