<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>title</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>새로운 글 리스트</h2>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성 일자</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:if test="${empty vos}">
			<tr>
				<td colspan="7" class="text-center">검색 결과가 없습니다!</td>
			</tr>
		</c:if>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
    	<tr>
			<td>${st.count}</td>
			<td class="text-left">
				<c:if test="${vo.hour_diff<=24}">
					<img src="${ctp}/images/new.gif"/>
				</c:if>
				<a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pageVo.pag}&pageSize=${pageVo.pageSize}&flag=${flag}&search=${pageVo.search}&searchString=${pageVo.searchString}">
					${vo.title}
				</a>
				<a>
					<c:if test="${vo.replyCount!=0}">
						[${vo.replyCount}]
					</c:if>
				</a>
			</td>
			<td>${vo.nickName}</td>
			<%-- <td>${fn:substring(vo.WDate,0,10)}(${vo.day_diff})</td> --%>
			<td>
				<c:if test="${vo.day_diff > 0}">
					<c:if test="${vo.hour_diff > 24}">
						${fn:substring(vo.WDate,0,10)}
					</c:if>
					<c:if test="${vo.hour_diff <= 24}">
						${fn:substring(vo.WDate,0,19)}
					</c:if>
				</c:if>
				<c:if test="${vo.day_diff <= 0}">                  
					${fn:substring(vo.WDate,11,19)}
				</c:if>
			</td>
			<td>${vo.readNum}</td>
			<td>${vo.good}</td>
    	</tr>
    	<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
    	</c:forEach>
    	<tr><td colspan="6" class="m-0 p-0"></tr>
  	</table>
</div>
<p><br/></p>
</body>
</html>