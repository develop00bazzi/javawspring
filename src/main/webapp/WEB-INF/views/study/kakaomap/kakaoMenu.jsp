<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!-- kakaoMenu.jsp -->

<div>
	<p>
		<a href="${ctp}/study/kakaomap/kakaoEx1" class="btn btn-success">마커 표시 / DB 저장</a> &nbsp;
		<a href="${ctp}/study/kakaomap/kakaoEx2" class="btn btn-success">DB에 저장된 지명 검색 / 삭제</a> &nbsp;
		<a href="${ctp}/study/kakaomap/kakaoEx3" class="btn btn-success">카카오 제공 DB 자료 저장하기</a> &nbsp;
		<a href="${ctp}/study/kakaomap/kakaoEx4" class="btn btn-success">카테고리별 장소 조회</a> &nbsp;
	</p>
</div>