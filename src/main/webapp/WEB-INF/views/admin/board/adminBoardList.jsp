<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boardList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		function pCheck() {
			let pageSize=document.getElementById("pageSize").value;
			location.href="${ctp}/admin/board/boardList?pageSize="+pageSize+"&flag=${flag}&search=${search}&searchString=${searchString}";
		}
		
		function searchCheck() {
			
			let searchString=$("#searchString").val();
			
			if(searchString.trim()=="") {
				alert("찾고자 하는 검색어를 입력해주세요.");
				searchForm.searchString.focus();
			}
			else {
				searchForm.submit();
			}
			
		}
		
		// 전체선택
	  	  $(function(){
	  	  	$("#checkAll").click(function(){
	  	  		if($("#checkAll").prop("checked")) {
	  		    		$(".board").prop("checked", true);
	  	  		}
	  	  		else {
	  		    		$(".board").prop("checked", false);
	  	  		}
	  	  	});
	  	  });
	  	  
	  	  // 선택항목 반전
	  	  $(function(){
	  	  	$("#reverseAll").click(function(){
	  	  		$(".board").prop("checked", function(){
	  	  			return !$(this).prop("checked");
	  	  		});
	  	  	});
	  	  });
	  	  
	  	function selectDelCheck() {
	  		  let ans=confirm("선택한 게시글을 삭제하시겠습니까?");
	  		  
	  		  if(!ans) return false;
	  		  
	  		  let deleteBoards="";
	  		  
	  		  for(let i=0; i<myform.board.length; i++) {
	  			  if(myform.board[i].checked == true) deleteBoards += myform.board[i].value + "/";
	  		  }
	  		  
	  		$.ajax({
		  		type : "post",
		  		url  : "${ctp}/admin/board/boardSelectDelete",
		  		data : {deleteBoards : deleteBoards},
		  		success:function(res) {
		  			if(res == "1") {
		  				alert("삭제 성공!");
		  			  	location.reload();
		  			}
		  		},
		  		error  :function() {
		  			alert("전송 오류!");
		  		}
		  	});
	  		  
	  	  }
		
	</script>
	<style type="text/css">
		th {
			text-align: center;
			background-color: #eee;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
	<a href="${ctp}/admin/board/boardList">
		<h2 class="text-center">관리자 게시판 관리</h2>
	</a>
	 
	<br/>
	
	<form name="myform">
		<table class="table table-borderless">
			<tr>
				<td class="text-left p-0">
					<%-- <c:if test="${sLevel!=4}">
						<a href="${ctp}/admin/board/boardInput?pag=${pageVo.pag}&pageSize=${pageVo.pageSize}" class="btn btn-sm btn-secondary">글쓰기</a>
					</c:if> --%>
					<input type="checkbox" id="checkAll" /> 전체선택/해제 &nbsp;&nbsp;
			        <input type="checkbox" id="reverseAll" /> 선택반전 &nbsp;&nbsp;
			        <input type="button" value="선택항목삭제" onclick="selectDelCheck()" class="btn btn-danger btn-sm"/>
				</td>
				<td class="text-right p-0">
					<select name="pageSize" id="pageSize" onchange="pCheck()">
						<option value="5" ${pageVo.pageSize==5?'selected':''}>5건</option>
						<option value="10" ${pageVo.pageSize==10?'selected':''}>10건</option>
						<option value="15" ${pageVo.pageSize==15?'selected':''}>15건</option>
						<option value="20" ${pageVo.pageSize==20?'selected':''}>20건</option>
					</select>
				</td>
			</tr>
		</table>
		
	
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>선택</th>
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
		    <c:forEach var="vo" items="${vos}">
	    	<tr>
	    		<td><input type="checkbox" name="board" id="board" class="board" value="${vo.idx}"/></td>
				<td>${curScrStartNo}</td>
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
	  	
	 
	  	
	  		<!-- 첫 페이지 | 이전블록 | 1(4) 2(5) 3(6) | 다음블록 | 마지막 페이지 -->
		<div class="text-center">
			<ul class="pagination justify-content-center">
				<c:if test="${pageVo.pag>1}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/board/boardList?pag=1&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">첫 페이지</a></li>
				</c:if>
				<c:if test="${pageVo.curBlock>0}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/board/boardList?pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">이전 블록</a></li>
				</c:if>
				<c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize+1}" end="${(pageVo.curBlock)*pageVo.blockSize+pageVo.blockSize}" varStatus="st">
					<c:if test="${i<=pageVo.totPage && i==pageVo.pag}">
						<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/board/boardList?pag=${i}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">${i}</a></li>
					</c:if>
					<c:if test="${i<=pageVo.totPage && i!=pageVo.pag}">
						<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/board/boardList?pag=${i}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${pageVo.curBlock<pageVo.lastBlock}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/board/boardList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&flag=${flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">다음 블록</a></li>
				</c:if>
				<c:if test="${pageVo.pag<pageVo.totPage}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/board/boardList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">마지막 페이지</a></li>
				</c:if>
			</ul>
		</div>
		<br/>
	</form>
	
	<!-- 검색기 처리 -->
	
	<div class="container text-center">
		<%-- <form name="searchForm" method="post" action="${ctp}/boSearch.bo"> --%>
		<form name="searchForm">
			<b>검색: </b>
			<select name="search">
				<option value="title">글 제목</option>
				<option value="nickName">글쓴이</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString" value="${pageVo.searchString}"/>
			<input type="button" value="검색" onclick="searchCheck()" class="btn btn-sm btn-secondary" />
			<input type="hidden" name="pag" value="${pageVo.pag}" />
			<input type="hidden" name="pageSize" value="${pageVo.pageSize}" />
		</form>
	</div>
	
	
</div>
<p><br/></p>
</body>
</html>