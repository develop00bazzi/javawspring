<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberPwdUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
    function pwdUpdate() {
    	let pwd = document.getElementById("pwd").value;
    	
    	if(pwd.trim() == "") {
    		alert("비밀번호를 입력하세요");
    		document.getElementById("pwd").focus();
    	}
    	else {
    		let ans=confirm("정말로 비밀번호를 변경하시겠습니까?");
			if(!ans) return false;    		
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" class="was-validated">
	  <h2 class="text-center">비밀번호 변경</h2>
	  <br/>
	  <table class="table table-bordered">
	    <tr>
	      <th>변경하고 싶은 비밀번호를 입력해주세요!</th>
	      <td>
	        <input type="password" name="pwd" id="pwd" autofocus required class="form-control"/>
	        <div class="invalid-feedback">비밀번호를 입력하세요.</div>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="2" class="text-center">
	        <input type="button" value="확인" onclick="pwdUpdate()" class="btn btn-success"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-success"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-success"/>
	      </td>
	    </tr>
	  </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>