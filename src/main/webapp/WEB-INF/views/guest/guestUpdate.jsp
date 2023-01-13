<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>guestInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2 class="text-center">방 명 록 글 수 정</h2>
	<form name="myform" method="post" class="was-validated">
	  <div class="form-group">
	    <label for="name">성명</label>
	    <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" value="${vo.name}" required>
	    <div class="valid-feedback">성명 입력 완료</div>
	    <div class="invalid-feedback">성명 입력은 필수입니다!</div>
	  </div>
	  <div class="form-group">
	    <label for="email">이메일</label>
	    <input type="text" class="form-control" id="email" placeholder="이메일 입력은 선택사항입니다." name="email" value="${vo.email}" >
	  </div>
	  <div class="form-group">
	    <label for="homePage">개인 홈페이지 주소</label>
	    <input type="text" class="form-control" id="homePage" value="http://" placeholder="개인 홈페이지 주소는 선택사항입니다." name="homePage" value="${vo.homePage}" >
	  </div>
	  <div class="form-group">
	    <label for="content">방문소감</label>
	    <textarea rows="5" class="form-control" id="content" name="content" required>${vo.content}</textarea>
	    <div class="valid-feedback">방명록 글 내용 입력 완료</div>
	    <div class="invalid-feedback">방명록 글 내용 입력은 필수입니다!</div>
	  </div>
	  <div class="form-group">
		  <button type="submit" class="btn btn-secondary">수정하기</button>
		  <button type="reset" class="btn btn-secondary">정정</button>
		  <button type="button" onclick="location.href='${ctp}/guest/guestList';" class="btn btn-secondary">돌아가기</button>
	  </div>
	  <input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>" />
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>