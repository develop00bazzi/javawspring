<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		function pCheck() {
			let pageSize=document.getElementById("pageSize").value;
			location.href="${ctp}/member/memberList?pageSize="+pageSize;
		}
		
		function midSearch() {
			let searchString=myform.searchString.value;
			if(searchString.trim()=="") {
				alert("찾고자 하는 검색어를 입력해주세요!");
				myform.searchString.focus();
			}
			else {
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
	<h2>전체 회원 리스트</h2>
	<br/>
	<form name="myform" method="post">
		<div class="row mb-2">
			<div class="col form-inline">
				<select name="search" class="form-control">
					<option value="mid">아이디</option>
					<option value="name">성명</option>
					<option value="nickName">닉네임</option>
				</select>
				<input type="text" name="searchString" class="form-control" autofocus />&nbsp;
				<input type="button" value="회원 개별 검색" onclick="midSearch();" class="btn btn-secondary" />
			</div>
			<div class="col text-right"><button type="button" onclick="location.href='${ctp}/member/memberList';" class="btn btn-secondary">전체 검색</button></div>
		</div>
	</form>
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td style="text-align:left;">
				<form>
					<p>
						회원정보 조회 수
						<select id="pageSize" onchange="pCheck()">
							 <option value="5" <c:if test="${pageSize==5}">selected</c:if>>5개</option> 
							 <option value="10" <c:if test="${pageSize==10}">selected</c:if>>10개</option>
							 <option value="15" <c:if test="${pageSize==15}">selected</c:if>>15개</option>
							 <option value="20" <c:if test="${pageSize==20}">selected</c:if>>20개</option>
						</select>
					</p>
				</form>
			</td>
			<td style="text-align:right;">
				<!-- 첫 페이지 / 이전 페이지 / 현 페이지 번호 /총 페이지 수) / 다음 페이지 / 마지막 페이지 -->
				<c:if test="${pageVo.pag>1}">
					<a href="${ctp}/member/memberList?pag=1&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">첫 페이지</a>
					<a href="${ctp}/member/memberList?pag=${pageVo.pag-1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">이전 페이지</a>
				</c:if>
				${pageVo.pag}/${pageVo.totPage}
				<c:if test="${pageVo.pag<pageVo.totPage}">
					<a href="${ctp}/member/memberList?pag=${pageVo.pag+1}&pageSize=${pageVo.pageSize}"  class="btn-sm btn-secondary"> 다음 페이지</a>
					<a href="${ctp}/member/memberList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}"  class="btn-sm btn-secondary"> 마지막 페이지</a>
				</c:if>
			</td>
		</tr>
	</table>
	
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>별명</th>
			<th>성명</th>
			<th>성별</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx }</td>
				<td><a href="${ctp}/member/memberInfor?mid=${vo.mid}&pag=${pag}">${vo.mid}</a></td>
				<td>${vo.nickName }</td>
				<td>${vo.name}	<c:if test="${sLevel==0 && vo.userInfor=='비공개'}"><font color="red">비공개</font></c:if></td>
				<td>${vo.gender }</td>
			</tr>
		</c:forEach>
		<tr><td colspan="5" class="m-0 p-0"></td></tr>
	</table>
	

	<!-- 첫 페이지 | 이전블록 | 1(4) 2(5) 3(6) | 다음블록 | 마지막 페이지 -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVo.pag>1}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=1&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">첫 페이지</a></li>
			</c:if>
			<c:if test="${pageVo.curBlock>0}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">이전 블록</a></li>
			</c:if>
			<c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize+1}" end="${(pageVo.curBlock)*pageVo.blockSize+pageVo.blockSize}" varStatus="st">
				<c:if test="${i<=pageVo.totPage && i==pageVo.pag}">
					<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberList?pag=${i}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
				<c:if test="${i<=pageVo.totPage && i!=pageVo.pag}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${i}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${pageVo.curBlock<pageVo.lastBlock}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">다음 블록</a></li>
			</c:if>
			<c:if test="${pageVo.pag<pageVo.totPage}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">마지막 페이지</a></li>
			</c:if>
		</ul>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>