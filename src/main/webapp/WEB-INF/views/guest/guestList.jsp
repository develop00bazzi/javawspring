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
		body{
		    margin-top:20px;
		    background:#eee;
		}
		@media (min-width: 0) {
		    .g-mr-15 {
		        margin-right: 1.07143rem !important;
		    }
		}
		@media (min-width: 0){
		    .g-mt-3 {
		        margin-top: 0.21429rem !important;
		    }
		}
		
		.g-height-50 {
		    height: 50px;
		}
		
		.g-width-50 {
		    width: 50px !important;
		}
		
		@media (min-width: 0){
		    .g-pa-30 {
		        padding: 2.14286rem !important;
		    }
		}
		
		.g-bg-secondary {
		    background-color: #fafafa !important;
		}
		
		.u-shadow-v18 {
		    box-shadow: 0 5px 10px -6px rgba(0, 0, 0, 0.15);
		}
		
		.g-color-gray-dark-v4 {
		    color: #777 !important;
		}
		
		.g-font-size-12 {
		    font-size: 0.85714rem !important;
		}
		
		.media-comment {
		    margin-top:20px
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
				<c:if test="${pageVo.pag>1}">
					<a href="${ctp}/guest/guestList?pag=1&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">첫 페이지</a>
					<a href="${ctp}/guest/guestList?pag=${pageVo.pag-1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">이전 페이지</a>
				</c:if>
				${pageVo.pag}/${pageVo.totPage}
				<c:if test="${pageVo.pag<pageVo.totPage}">
					<a href="${ctp}/guest/guestList?pag=${pageVo.pag+1}&pageSize=${pageVo.pageSize}"  class="btn-sm btn-secondary"> 다음 페이지</a>
					<a href="${ctp}/guest/guestList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}"  class="btn-sm btn-secondary"> 마지막 페이지</a>
				</c:if>
			</td>
		</tr>
	</table>
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
	<div class="container">
	<div class="row">
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		    <div class="col-md-8">
		        <div class="media g-mb-30 media-comment">
		            <img class="d-flex g-width-50 g-height-50 rounded-circle g-mt-3 g-mr-15" src="${ctp}/images/noimage.jpg" alt="Image Description">
		            <div class="media-body u-shadow-v18 g-bg-secondary g-pa-30">
		              <div class="g-mb-15">
		              	<span>${curScrStartNo}</span>
		                <h5 class="h5 g-color-gray-dark-v1 mb-0">${vo.name}</h5>
		                <span class="g-color-gray-dark-v4 g-font-size-12">${fn:substring(vo.visitDate,0,19)}</span>
		              </div>
		        
		              <p>${vo.content}</p>
		        
		              <ul class="list-inline d-sm-flex my-0">
		                <li class="list-inline-item g-mr-20">
		                  <!-- <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!">
		                    <i class="fa fa-thumbs-up g-pos-rel g-top-1 g-mr-3"></i>
		                    178
		                  </a> -->
		                  <a href="javascript:guestUpdateCheck(${vo.idx})" class="btn-primary badge rounded-pill">수정</a>
		                </li>
		                <li class="list-inline-item g-mr-20">
		                  <!-- <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!">
		                    <i class="fa fa-thumbs-down g-pos-rel g-top-1 g-mr-3"></i>
		                    34
		                  </a> -->
		                  <c:if test="${sMid=='admin'}"><a href="javascript:delCheck(${vo.idx})" class="btn-danger badge rounded-pill">삭제</a></c:if>
		                </li>
		                <li class="list-inline-item ml-auto">
		                  <a class="u-link-v5 g-color-gray-dark-v4 g-color-primary--hover" href="#!">
		                    <!-- <i class="fa fa-reply g-pos-rel g-top-1 g-mr-3"></i>
		                    Reply -->
		                    ${vo.hostIp}
		                  </a>
		                </li>
		              </ul>
		            </div>
		        </div>
		    </div>
	    <c:set var="curScrStartNo" value="${curScrStartNo-1}" />
	    </c:forEach> 
	</div>
	</div>
	
	<p><br/></p>
	
	<!-- 첫 페이지 | 이전블록 | 1(4) 2(5) 3(6) | 다음블록 | 마지막 페이지 -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVo.pag>1}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=1&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">첫 페이지</a></li>
			</c:if>
			<c:if test="${pageVo.curBlock>0}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">이전 블록</a></li>
			</c:if>
			<c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize+1}" end="${(pageVo.curBlock)*pageVo.blockSize+pageVo.blockSize}" varStatus="st">
				<c:if test="${i<=pageVo.totPage && i==pageVo.pag}">
					<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/guest/guestList?pag=${i}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
				<c:if test="${i<=pageVo.totPage && i!=pageVo.pag}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${i}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${pageVo.curBlock<pageVo.lastBlock}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">다음 블록</a></li>
			</c:if>
			<c:if test="${pageVo.pag<pageVo.totPage}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/guest/guestList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}" class="btn-sm btn-secondary">마지막 페이지</a></li>
			</c:if>
		</ul>
	</div>
	
	<p><br/></p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>