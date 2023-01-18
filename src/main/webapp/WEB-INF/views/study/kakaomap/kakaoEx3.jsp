<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>kakaoEx3.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function saveInfoDB(latitude,longitude,address) {
    		// alert("경도: "+latitude+"위도: "+longitude+"주소: "+address);
    		
    		var query={
   					address:address,
   					latitude:latitude,
   					longitude:longitude
   			}
   			
   			$.ajax({
   				type:"post",
   				url:"${ctp}/study/kakaomap/kakaoEx1",
   				data:query,
   				success:function(res) {
   					if(res=="1") alert("선택한 장소가 추가되었습니다!");
   					else alert("이미 추가된 장소입니다!");
   				},
   				error:function() {
   					alert("전송 오류!");
   				}
   			});
    		
    	}
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2>카카오에서 제공하는 DB 활용 저장하기</h2>

	<div id="map" style="width:100%;height:500px;"></div>
	
	<hr/>
	
	<form name="myform">
		<p>검색하고 싶은 장소를 입력해주세요!</p>
		<input type="text" name="search" id="search" class="form-control mb-3">
		<input type="button" onclick="searchCheck()" value="장소 찾기" class="btn btn-primary" />
	</form>
	
	<hr/>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5b97ef649f5d9df28ecf21280488505c&libraries=services"></script>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places(); 
	
	function searchCheck() {
		var search=myform.search.value;
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(search, placesSearchCB); 
	}
	
	
	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new kakao.maps.LatLngBounds();
	
	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}
	
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	
	    // 마커에 클릭이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        
	        var info='<div style="padding:5px;font-size:12px;"><b>' + place.place_name + '</b></div>';
	        info += '<hr/>';
	        info += '<div style="padding:5px;font-size:12px;">';
	        info += '<p>현재 장소 DB에 추가</p>';
	        info += '<input type="button" value="저장" onclick="saveInfoDB(\''+place.y+'\',\''+place.x+'\',\''+place.place_name+'\')" class="btn btn-sm btn-secondary" /> ';
	        info += '';
	        info += '';
	        info += '';
	        info += '';
	        info += '';
	        info += '</div>';
	        
	        infowindow.setContent(info);
	        infowindow.open(map, marker);
	    });
	}
	</script>
	
	<jsp:include page="kakaoMenu.jsp"></jsp:include>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>