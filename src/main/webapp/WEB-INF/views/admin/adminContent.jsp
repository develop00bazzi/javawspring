<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body style="background-color: pink;">
<p><br/></p>
<div class="container">
	<h5>관리자 홈 화면</h5>
	<hr/>
	<p>
		신규 가입자 : 
	</p>
	<hr/>
	<div>
		<p>새로운 글</p>
		<iframe frameborder="no" width="100%" height="400px" src="${ctp}/admin/board/newBoardList"></iframe>
	</div>
	<hr/>
	<div>
		<p>탈퇴 신청 회원</p>
		<%-- <iframe frameborder="no" width="100%" height="600px" src="${ctp}/adMemDelList.ad"></iframe> --%>
	</div>
</div>
<p><br/></p>
</body>
</html>