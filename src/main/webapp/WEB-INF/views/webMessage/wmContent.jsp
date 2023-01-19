<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("newLine", "\n"); %>

<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>wmContent.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	
    </script>
</head>
<body>
<div class="container">
	<table class="table table-bordered">
		<tr>
			<th>발송자</th>
			<td>${vo.sendId}</td>
		</tr>
		<tr>
			<th>수신자</th>
			<td>${vo.receiveId}</td>
		</tr>
		<tr>
			<th>메세지 제목</th>
			<td>${vo.title}</td>
		</tr>
		<tr>
			<th>발송자</th>
			<td style="width: 70%; height: 150px;">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:if test="${param.mFlag == 1 || param.mFlag == 2}">
					<input type="button" value="답장 작성" onclick="location.href='webMessage?mSw=0&receiveId=${vo.sendId}';" class="btn btn-primary" /> &nbsp;
				</c:if>
				<c:if test="${param.mFlag==1}">
					<input type="button" value="휴지통으로 이동" onclick="location.href='webDeleteCheck?mSw=5&idx=${vo.idx}&mFlag=${param.mFlag}';" class="btn btn-warning" /> &nbsp;
				</c:if>
				<%-- <c:if test=""> --%>
					<input type="button" value="돌아가기" onclick="location.href='webMessage?mSw=1';" class="btn btn-secondary" /> &nbsp;
				<%-- </c:if> --%>
			</td>
		</tr>	
	</table>
</div>
<p><br/></p>
</body>
</html>
<!-- 

mSw => 1: 받은 메세지, 2: 새로운 메세지, 3: 보낸 메세지, 4: 수신 확인, 5: 휴지통, 6: 메세지 상세보기 0: 메세지 작성
mFlag => 1: 받은 메세지 , 2: 새 메세지, 3: 보낸 메세지 , 5: 휴지통

-->