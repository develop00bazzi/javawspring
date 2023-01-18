aka<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>kakaomap.jsp (기본지도)</title>
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

	<h2>KAKAO맵 API 기본 지도</h2>
	<hr/>
	
	<div id="map" style="width:100%;height:500px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5b97ef649f5d9df28ecf21280488505c"></script>
	<script>
		var container = document.getElementById('map');	// 지도를 표시할 div 태그의 아이디를 설정
		var options = {
			center: new kakao.maps.LatLng(36.62424020027349, 127.47858498274377),	// 지도의 중심 좌표 설정
			level: 3 	// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(container, options);
	</script>
	
	<hr/>
	
	<jsp:include page="kakaoMenu.jsp"></jsp:include>

</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>