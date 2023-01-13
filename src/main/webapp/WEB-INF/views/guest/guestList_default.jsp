<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>guestList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<style>
		th {
			text-align:center;
			background-color:#ccc;
		}
		
	</style>
	<script>
		'use strict';
		
		function delCheck(idx) {
			let ans=confirm("정말로 삭제하시겠습니까?");
			if(ans) location.href="${ctp}/guestDelete?idx="+idx;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2 style="text-align:center;">방 명 록 리 스 트</h2>
	<br/>
	<table class="table table-borderless mb-0">
		<tr>
			<td style="text-align:left;">
				<c:if test="${sAMid!='admin'}"><a href="${ctp}/adminLogin" class="btn btn-sm btn-secondary">관리자</a></c:if>
				<c:if test="${sAMid=='admin'}"><a href="${ctp}/adminLogout" class="btn btn-sm btn-secondary">관리자 로그아웃</a></c:if>
			</td>
			<td style="text-align:right;"><a href="${ctp}/guest/guestInput" class="btn btn-sm btn-secondary">글쓰기</a></td>
		</tr>
	</table>
	<c:set var="no" value="${fn:length(vos)}"/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<table class="table table-borderless mb-0">
			<tr>
				<td style="text-align:left;">방문번호: ${no}
					<c:if test="${sAMid=='admin'}"><a href="javascript:delCheck(${vo.idx})" class="btn btn-sm btn-danger">삭제</a></c:if>
				</td>
				<td style="text-align:right;">방문 IP: ${vo.hostIp}</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th style="width:20%;">성명</th>
				<td style="width:25%;">${vo.name}</td>
				<th style="width:20%;">방문일자</th>
				<td style="width:35%;">${fn:substring(vo.visitDate,0,19)}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">
					<c:set var="email" value="${vo.email}"/>
					<c:choose>
						<c:when test="${fn:contains(email,'@')}">${vo.email}</c:when>
						<c:otherwise>이메일 입력 오류</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>개인 홈페이지 주소</th>
				<td colspan="3">
					<c:if test="${fn:length(vo.homePage)<=9}">홈페이지 없음</c:if>
					<c:if test="${fn:length(vo.homePage)>9}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
				</td>
			</tr>
			<tr>
				<th>방문 소감</th>
				<td colspan="3">${fn:replace(vo.content,newLine,'<br/>')}</td>
			</tr>
		</table>
		<br/>
		<c:set var="no" value="${no-1}" />
	</c:forEach>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
</html>