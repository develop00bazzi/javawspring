<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberPwdSearch.jsp</title>
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
	<h2>비밀번호 찾기</h2>
	<p>아이디와 이메일 주소를 입력 후 메일로 임시 비밀번호를 발급받으세요!</p>
	<form name="myform" method="post">
		<table class="table table-bordered">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="mid" id="mid" class="form-control"/></td>
			</tr>
			<tr>
				<th>메일 주소</th>
				<td><input type="text" name="toMail" id="toMail" class="form-control"/></td>
				
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="임시 비밀번호 발급" class="btn btn-primary"/>
					<input type="reset" value="다시 입력" class="btn btn-primary">
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-secondary">
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>