<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>guList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<style>
		th {
			text-align:center;
			background-color:#ccc;
		}
	</style>
	<script>
		'use strict';
		
		function delCheck(idx) {
			let ans=confirm("정말로 삭제하시겠습니까?");
			if(ans) location.href="${ctp}/guest/guestDelete?idx="+idx;
		}
		
		function pCheck() {
			let pageSize=document.getElementById("pageSize").value;
			location.href="${ctp}/guest/guestList?pageSize="+pageSize;
		}
		
		function guestUpdateCheck(idx) {
			let ans=confirm("게시글을 수정하시겠습니까?");
			if(ans) location.href="${ctp}/guest/guestUpdate?idx="+idx;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2 style="text-align:center;">방 명 록 리 스 트</h2>
	<br/>
	<table class="table table-borderless mb-0">
		<tr>
			<td style="text-align:left;">
				<%-- <c:if test="${sAMid!='admin'}"><a href="${ctp}/adminLogin.gu" class="btn btn-sm btn-secondary">관리자</a></c:if> --%>
				<%-- <c:if test="${sMid=='admin'}"><a href="${ctp}/member/adminLogout" class="btn btn-sm btn-secondary">관리자 로그아웃</a></c:if> --%>
			</td>
			<td style="text-align:right;"><a href="${ctp}/guest/guestInput" class="btn btn-sm btn-secondary">글쓰기</a></td>
		</tr>
	</table>
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td style="text-align:left;">
				<form>
					<p>
						게시글 수
						<select id="pageSize" onchange="pCheck()">
							 <option value="5" <c:if test="${pageSize==5}">selected</c:if>>5개</option> 
							 <option value="10" <c:if test="${pageSize==10}">selected</c:if>>10개</option>
							 <option value="15" <c:if test="${pageSize==15}">selected</c:if>>15개</option>
							 <option value="20" <c:if test="${pageSize==20}">selected</c:if>>20개</option>
							 <c:if test=""></c:if>
						</select>
					</p>
				</form>
			</td>
			<td style="text-align:right;">
				<!-- 첫 페이지 / 이전 페이지 / 현 페이지 번호 /총 페이지 수) / 다음 페이지 / 마지막 페이지 -->
				<c:if test="${pag>1}">
					<a href="${ctp}/guest/guestList?pag=1&pageSize=${pageSize}" class="btn-sm btn-secondary">첫 페이지</a>
					<a href="${ctp}/guest/guestList?pag=${pag-1}&pageSize=${pageSize}" class="btn-sm btn-secondary">이전 페이지</a>
				</c:if>
				${pag}/${totPage}
				<c:if test="${pag<totPage}">
					<a href="${ctp}/guest/guestList?pag=${pag+1}&pageSize=${pageSize}"  class="btn-sm btn-secondary"> 다음 페이지</a>
					<a href="${ctp}/guest/guestList?pag=${totPage}&pageSize=${pageSize}"  class="btn-sm btn-secondary"> 마지막 페이지</a>
				</c:if>
			</td>
		</tr>
	</table>
	<c:set var="curScrStartNo" value="${curScrStartNo}"/>
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<table class="table table-borderless mb-0">
			<tr>
				<td style="text-align:left;">방문번호: ${curScrStartNo}
					<c:if test="${sMid=='admin'}"><a href="javascript:delCheck(${vo.idx})" class="btn-danger badge rounded-pill">삭제</a></c:if>
				</td>
				<td style="text-align:right;">
					<a href="javascript:guestUpdateCheck(${vo.idx})" class="btn-primary badge rounded-pill">수정</a>
					방문 IP: ${vo.hostIp}
				</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th style="width:20%;">성명</th>
				<td style="width:25%;">${vo.name}</td>
				<th style="width:20%;">방문일자</th>
				<td style="width:35%;">${fn:substring(vo.visitDate,0,19)}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3">
					<c:set var="email" value="${vo.email}"/>
					<c:choose>
						<c:when test="${fn:contains(email,'@')}">${vo.email}</c:when>
						<c:otherwise>이메일 입력 오류</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>개인 홈페이지 주소</th>
				<td colspan="3">
					<c:if test="${fn:length(vo.homePage)<=9}">홈페이지 없음</c:if>
					<c:if test="${fn:length(vo.homePage)>9}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
				</td>
			</tr>
			<tr>
				<th>방문 소감</th>
				<td colspan="3">${fn:replace(vo.content,newLine,'<br/>')}</td>
			</tr>
		</table>
		<br/>
	<c:set var="curScrStartNo" value="${curScrStartNo-1}" />
	</c:forEach>
	
	<!-- 첫 페이지 | 이전블록 | 1(4) 2(5) 3(6) | 다음블록 | 마지막 페이지 -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pag>1}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=1&pageSize=${pageSize}" class="btn-sm btn-secondary">첫 페이지</a></li>
			</c:if>
			<c:if test="${curBlock>0}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}" class="btn-sm btn-secondary">이전 블록</a></li>
			</c:if>
			<c:forEach var="i" begin="${(curBlock)*blockSize+1}" end="${(curBlock)*blockSize+blockSize}" varStatus="st">
				<c:if test="${i<=totPage && i==pag}">
					<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/guest/guestList?pag=${i}&pageSize=${pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
				<c:if test="${i<=totPage && i!=pag}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${i}&pageSize=${pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${curBlock<lastBlock}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}" class="btn-sm btn-secondary">다음 블록</a></li>
			</c:if>
			<c:if test="${pag<totPage}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${totPage}&pageSize=${pageSize}" class="btn-sm btn-secondary">마지막 페이지</a></li>
			</c:if>
		</ul>
	</div>
	
	<p><br/></p>
	
	<!-- 검색기 처리 -->
	
	<div class="container text-center">
		<%-- <form name="searchForm" method="post" action="${ctp}/boList.bo"> --%>
		<form name="searchForm" method="post">
			<b>검색: </b>
			<select name="search">
				<option value="name">방문자</option>
				<option value="email">이메일</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString" value="${searchString}"/>
			<input type="button" value="검색" onclick="searchCheck()" class="btn btn-sm btn-secondary" />
			<input type="hidden" name="pag" value="${pag}" />
			<input type="hidden" name="pageSize" value="${pageSize}" />
			<input type="hidden" name="flag" value="search"/>
		</form>
	</div>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>