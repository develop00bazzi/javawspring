<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2>아이디 검색 결과 (총 ${fn:length(vos)}건)</h2>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>닉네임</th>
			<th>아이디</th>
		</tr>
		<c:if test="${empty vos}">
			<tr>
				<td colspan="3">
					<font color="red"><b>찾으시는 정보가 없습니다!</b></font>
				</td>
			</tr>
		</c:if>
		<c:if test="${!empty vos}">
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>*${fn:substring(vo.nickName,1,fn:length(vo.nickName))}</td>
					<td>**${fn:substring(vo.mid,2,fn:length(vo.mid))}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div class="form-group text-center">
		<button type="button" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-secondary">로그인 창으로 이동</button>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>