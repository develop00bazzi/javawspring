<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>memberDelete.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function memberDelete() {
    		let pwd=myform.pwd.value;
    		
    		if(pwd.trim()=="") {
    			alert("비밀번호를 입력해주시기 바랍니다!");
    			myform.pwd.focus;
    			return false;
    		}
    		
    		let ans=confirm("정말로 회원 탈퇴를 하시겠습니까?");
    		if(!ans) return false;
    		myform.submit();
    		
    	}
    	
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
				<h2>회원 탈퇴 신청</h2>
				<p>회원 탈퇴 신청을 하시려면 비밀번호를 입력해주시기 바랍니다!</p>
				  <div class="form-group">
				    <label for="mid">회원 비밀번호</label>
				    <input type="text" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요!"  required>
				    <div class="valid-feedback">비밀번호 입력 완료!</div>
				    <div class="invalid-feedback">회원 탈퇴를 하시려면 비밀번호를 입력해주셔야 합니다!</div>
				  </div>
				  <div class="form-group text-center">
					  <button type="button" onclick="memberDelete()" class="btn btn-secondary">회원 탈퇴 신청</button>
					  <button type="reset" class="btn btn-secondary">정정</button>
					  <button type="button" onclick="location.href='${ctp}/';" class="btn btn-secondary">돌아가기</button>
				  </div>
				  
				</form>
			</div>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>