<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminLeft.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body style="background-color: gray;">
<p><br/></p>
<div class="container text-center">
	<div id="accordion">
    <div class="card">
      <div class="card-header">
        <a class="card-link" data-toggle="collapse" href="#collapseOne">
          방명록 관리
        </a>
      </div>
      <div id="collapseOne" class="collapse" data-parent="#accordion">
        <div class="card-body">
          
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
        게시판 관리
      </a>
      </div>
      <div id="collapseTwo" class="collapse" data-parent="#accordion">
        <div class="card-body">
        	<p>
				<a href="${ctp}/admin/board/boardList" target="adminContent">게시판 게시글 조회</a>
			</p>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
          회원 관리
        </a>
      </div>
      <div id="collapseThree" class="collapse" data-parent="#accordion">
        <div class="card-body">
        	<p>
				<a href="${ctp}/admin/member/adminMemberList" target="adminContent">회원 관리</a>
			</p>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
          기타
        </a>
      </div>
      <div id="collapseFour" class="collapse" data-parent="#accordion">
        <div class="card-body">
        	<p>
        		<a href="${ctp}/admin/adminContent" target="adminContent" >관리자 메인</a>
       		</p>
			<p>
				<a href="${ctp}/" target="_top">홈으로</a>
			</p>
        	<p>
				<a href="${ctp}/admin/file/ckFileList" target="adminContent">게시판 글 작성 사진 관리</a>
			</p>
        	<p>
				<a href="${ctp}/admin/file/pdsDownFileList" target="adminContent">자료실 다운로드 관리</a>
			</p>
        </div>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>