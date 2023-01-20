<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>errorMain.jsp</title>
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
	<h2>에러 발생에 대한 대처 연습</h2>
	<hr/>
	<p>
		<pre>
			JSP 파일 View에서의 에러가 발생시에는 JSP 파일 상단에 @page 지시자를 이용한 에러 페이지로 이동할 수 있다.
			
		 	< % @ page errorPage="에러 발생시 수행할 JSP 파일 경로와 파일명" % >
		</pre>
		
		<a href="${ctp}/errorPage/error1" class="btn btn-secondary">JSP 파일 오류 발생</a>
	</p>
	<hr/>
	<p>
		<pre>
			서블릿(servlet)에서의 에러가 발생시에는 발생시를 대비하여 처리하는 방법
			
			- web.xml에 error에 필요한 설정을 미리 해둔다. (아래 코드 참조)
			
			< error-page>
				< error-code >400< /error-code >
				<!-- <location>/errorPage/error400</location> -->
				< location >/errorPage/errorOk< /location >
			< / error-page >
			
			
			
		 	< % @ page errorPage="에러 발생시 수행할 JSP 파일 경로와 파일명" % >
		</pre>
		
		<a href="${ctp}/errorPage/error2" class="btn btn-secondary">Servlet 오류 발생 (404 오류)</a>
		<a href="${ctp}/errorPage/error3" class="btn btn-primary">Servlet 오류 발생 (예외 오류)</a>
	</p>
	<hr/>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>