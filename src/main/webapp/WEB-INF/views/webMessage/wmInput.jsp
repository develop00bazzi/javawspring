<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>wmInput.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function fCheck() {
    		let receiveId=myform.receiveId.value;
    		let title=myform.title.value;
    		let content=myform.content.value;
    		
    		if(receiveId.trim()=="") {
    			alert("받는 사람 아이디를 입력하세요!");
    			myform.receiveId.focus();
    		}
    		else if(title.trim()=="") {
    			alert("메세지 제목을 입력하세요!");
    			myform.title.focus();
    		}
    		else if(content.trim()=="") {
    			alert("메세지 내용을 입력하세요!");
    			myform.content.focus();
    		}
    		else {
    			myform.submit();
    		}
    	}
    </script>
</head>
<!-- 

mSw => 1: 받은 메세지, 2: 새로운 메세지, 3: 보낸 메세지, 4: 수신 확인, 5: 휴지통, 6: 메세지 상세보기 0: 메세지 작성
mFlag => 11: 받은 메세지 , 12: 보낸 메세지, 13: 휴지통  

-->
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/webMessage/wmInput">
		<table class="table table-bordered">
			<tr>
				<th>보내는 사람</th>
				<td><input type="text" name="sendId" value="${sMid}" readonly="readonly" class="form-control"/></td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td><input type="text" name="receiveId" value="${param.receiveId}" placeholder="받는 사람의 아이디를 입력해주세요!" class="form-control"/></td>
			</tr>
			<tr>
				<th>메세지 제목</th>
				<td><input type="text" name="title" placeholder="메세지 제목을 입력하세요!" class="form-control"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="5" name="content" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="메세지 전송" onclick="fCheck()" class="btn btn-primary" /> &nbsp;
					<input type="reset" value="다시 작성" class="btn btn-warning" /> &nbsp;
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/webMessage/webMessage';" class="btn btn-primary" /> 
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
</body>
</html>