<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>transactionList.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<div class="row">
		<div class="col text-left"><h2>user 목록 리스트</h2></div>
		<div class="col text-right"><input type="button" value="입력 창으로" onclick="history.back();" class="btn btn-warning" /></div>
	</div>
	<table class="table table-hover">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>성명</th>
			<th>닉네임</th>
			<th>직업</th>
			<th>주소</th>
			<th>나이</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${st.count}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.nickName}</td>
				<td>${vo.job}</td>
				<td>${vo.address}</td>
				<td>${vo.age}</td>
			</tr>
		</c:forEach>
		<tr><td colspan="7" class="m-0 p-0"></td></tr>
	</table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>