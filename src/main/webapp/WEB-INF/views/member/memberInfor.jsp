<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memInfor.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2>회원 정보 상세 보기</h2>
	<br/>
	<table class="table">
		<tr><td>아이디: ${vo.mid }</td></tr>
		<tr><td>닉네임: ${vo.nickName }</td></tr>
		<tr><td>성명: ${vo.name }</td></tr>
		<tr><td>성별: ${vo.gender }</td></tr>
		<tr><td>생일: ${vo.birthday }</td></tr>
		<tr><td>전화번호: ${vo.tel }</td></tr>
		<tr><td>주소: ${vo.address }</td></tr>
		<tr><td>이메일: ${vo.email }</td></tr>
		<tr><td>홈페이지: ${vo.homePage }</td></tr>
		<tr><td>직업: ${vo.job }</td></tr>
		<tr><td>취미: ${vo.hobby }</td></tr>
		<tr><td>자기소개: ${vo.content }</td></tr>
		<tr><td>회원 등급: ${strLevel }</td></tr>
		<tr><td>총 방문 횟수: ${vo.visitCnt }</td></tr>
		<tr><td>최초 가입일: ${vo.startDate }</td></tr>
		<tr><td>최종 방문일: ${vo.lastDate }</td></tr>
		<tr><td>오늘 방문 횟수: ${vo.todayCnt }</td></tr>
		<c:if test="${sLevel==0}">
			<tr><td>총 포인트:${vo.point}</td></tr>
			<tr><td>정보 공개 유무:${vo.userInfor}</td></tr>
		</c:if>
		<tr><td>사진: <img src="${ctp}/member/${vo.photo}" width="150px" /></td></tr>
		<tr><td><button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memberList?pag=${pag}';">돌아가기</button></td></tr>
	</table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>