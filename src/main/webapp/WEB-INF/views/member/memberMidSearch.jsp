<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memMidSearch.jsp</title>
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
	<div class="modal-dailog">
		<div class="modal-content">
			<div class="container" style="padding:30px">
				<form name="myform" method="post" class="was-validated">
				<h2>회원 아이디 찾기</h2>
				<p>이메일을 입력해주세요!</p>
				  <div class="form-group">
				    <label for="mid">사용자 이메일</label>
				    <input type="text" class="form-control" id="email" name="email" placeholder="아이디를 찾으시려는 분의 이메일을 입력해주세요!"  required>
				    <div class="valid-feedback">이메일 입력 완료!</div>
				    <div class="invalid-feedback">아이디를 찾으시려면 이메일을 꼭 입력해주셔야 합니다!</div>
				  </div>
				  <div class="form-group text-center">
					  <button type="submit" class="btn btn-secondary">아이디 찾기!</button>
					  <button type="reset" class="btn btn-secondary">정정</button>
					  <button type="button" onclick="location.href='${ctp}/memLogin.mem';" class="btn btn-secondary">돌아가기</button>
				  </div>
				  
				</form>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>