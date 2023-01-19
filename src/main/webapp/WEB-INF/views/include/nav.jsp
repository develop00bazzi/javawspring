<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<script>
	window.Kakao.init("5b97ef649f5d9df28ecf21280488505c");
</script>

<script>
	function kakaoLogout() {
	    Kakao.Auth.logout()
	      .then(function() {
	        alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken());
	        deleteCookie();
	      })
	      .catch(function() {
	        alert('Not logged in');
	      });
	  }
</script>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-black w3-card">
  
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="http://192.168.50.65:9090/javawspring/" class="w3-bar-item w3-button w3-padding-large">배지훈 수업 프로젝트</a>
    <a href="${ctp}/guest/guestList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">방명록</a>
    
    <c:if test="${sLevel<=4}">
    
	    <a href="${ctp}/board/boardList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">게시판</a>
	    <a href="${ctp}/pds/pdsList" class="w3-bar-item w3-button w3-padding-large w3-hide-small">자료실</a>
	    
	    
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">수업 공부 자료 1 &nbsp;<i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/study/password/sha256" class="w3-bar-item w3-button">암호화 연습 1 (SHA256)</a>
	        <a href="${ctp}/study/password/aria" class="w3-bar-item w3-button">암호화 연습 2 (ARIA)</a>
	        <a href="${ctp}/study/password/bCryptPassword" class="w3-bar-item w3-button">암호화 연습 3 (BCryptPasswordEncoder)</a>
	        <a href="${ctp}/study/ajax/ajaxMenu" class="w3-bar-item w3-button">aJax 연습</a>
	        <a href="${ctp}/study/mail/mailForm" class="w3-bar-item w3-button">메일 연습</a>
	        <a href="${ctp}/study/fileUpload/fileUploadForm" class="w3-bar-item w3-button">파일 업로드 연습</a>
	        <a href="${ctp}/study/uuid/uuidForm" class="w3-bar-item w3-button">UUID 연습</a>
	        <a href="${ctp}/study/calendar/calendar" class="w3-bar-item w3-button">인터넷 달력</a>
	      </div>
	    </div>
	    
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">수업 공부 자료 2 &nbsp;<i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/study/qrCode" class="w3-bar-item w3-button">QR 코드 쿠폰 발급</a>
	        <a href="${ctp}/webMessage/webMessage" class="w3-bar-item w3-button">웹 메세지</a>
	        <a href="${ctp}/study/kakaomap/kakaomap" class="w3-bar-item w3-button">카카오맵</a>
	        <a href="#" class="w3-bar-item w3-button">구글 차트</a>
	        <a href="#" class="w3-bar-item w3-button">트랜잭션</a>
	      </div>
	    </div>
    
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">회원 정보 [&nbsp;${sNickName}&nbsp;] <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
	        <a href="${ctp}/member/memberMain" class="w3-bar-item w3-button">회원 메인 화면</a>
	        <a href="${ctp}/schedule/schedule" class="w3-bar-item w3-button">일정 관리</a>
	        <a href="${ctp}/member/memberList" class="w3-bar-item w3-button">회원 리스트</a>
	        <a href="${ctp}/member/memberUpdate" class="w3-bar-item w3-button">회원 정보 수정</a>
	        <a href="${ctp}/member/memberPwdUpdate" class="w3-bar-item w3-button">회원 비밀번호 변경</a>
	        <a href="${ctp}/member/memberDelete" class="w3-bar-item w3-button">회원 탈퇴</a>
	        <a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button">관리자 메뉴</a>
	      </div>
	    </div>
    </c:if>
    
    <c:if test="${empty sLevel || empty sMid}">
    	<a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">로그인</a>
    	<a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">회원가입</a>    	
    </c:if>
    <c:if test="${!empty sLevel || !empty sMid}">
   		<a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">로그아웃</a>
    	<%-- <c:if test="${empty sKakaoLogin}">
    	</c:if>
    	<c:if test="${!empty sKakaoLogin}">
    		<a href="javascript:kakaoLogout()" class="w3-bar-item w3-button w3-padding-large w3-hide-small">카카오 로그아웃</a>
    	</c:if> --%>
    </c:if>
    
    <a href="javascript:void(0)" class="w3-padding-large w3-hover-red w3-hide-small w3-right"><i class="fa fa-search"></i></a>
  </div>
</div>

<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
<div id="navDemo" class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top" style="margin-top:46px">
  <a href="#band" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">BAND</a>
  <a href="#tour" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">TOUR</a>
  <a href="#contact" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">CONTACT</a>
  <a href="#" class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">MERCH</a>
</div>