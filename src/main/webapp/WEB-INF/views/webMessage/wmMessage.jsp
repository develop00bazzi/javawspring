<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>wmMessage.jsp(메인)</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	#leftWindow {
    		float: left; 
    		width: 25%;
    		height: 520px;
    		text-align: center;
    		background-color: #ddd;
    	}
    	#rightWindow {
    		float: left; 
    		width: 75%;
    		height: 520px;
    		text-align: center;
    		background-color: #eee;
    		overflow: auto;
    	}
    	#footerMargin {
    		clear: both;
    		margin: 10px;
    	}
    	h3 {
    		text-align: center;
    	}
    	
    </style>
    <script>
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>

<!-- 

	mSw => 1: 받은 메세지, 2: 새로운 메세지, 3: 보낸 메세지, 4: 수신 확인, 5: 휴지통, 6: 메세지 상세보기 0: 메세지 작성
	mFlag => 1: 받은 메세지 , 2: 새 메세지, 3: 보낸 메세지 , 5: 휴지통
	
 -->
<p><br/></p>
<div class="container">
	<h3>[ 메세지 관리 ]</h3>
	<div>! 현재 접속자 : <font color='red'>${sMid}</font> !</div>
	
	<div id="leftWindow">
		<p><br/></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=0">메세지 작성</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=1&mFlag=1">받은 메세지</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=2&mFlag=2">새로운 메세지</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=3&mFlag=3">보낸 메세지</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=4">수신 확인</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=5&mFlag=5">휴지통</a></p>
		<p><a href="${ctp}/webMessage/webMessage?mSw=7">휴지통 비우기</a></p>
	</div>
	
	<div id="rightWindow">
		<p>
			<c:if test="${mSw==0}">
				<h3>메세지 작성</h3>
				<div class="text-right">
					<a href="#" class="btn btn-success btn-sm m-0 mr-3">주소록</a>
				</div>
				<jsp:include page="wmInput.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==1}">
				<h3>받은 메세지</h3>
				<jsp:include page="wmList.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==2}">
				<h3>새로운 메세지</h3>
				<jsp:include page="wmList.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==3}">
				<h3>보낸 메세지</h3>
				<jsp:include page="wmList.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==4}">
				<h3>수신 확인</h3>
				<jsp:include page="wmList.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==5}">
				<h3>휴지통</h3>
				<jsp:include page="wmList.jsp"></jsp:include>
			</c:if>
			<c:if test="${mSw==6}">
				<h3>메세지 내용보기</h3>
				<jsp:include page="wmContent.jsp"></jsp:include>
			</c:if>
		</p>
	</div>
	
</div>
<p><br/></p>
<div id="footerMargin">
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</div>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>