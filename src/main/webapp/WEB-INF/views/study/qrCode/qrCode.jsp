<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>qrCode.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function qrCreate(no) {
    		let mid='';
    		let email='';
    		let query='';
    		let moveUrl='';
    		
    		if(no==1) {
    			mid=myform.mid.value;
    			email=myform.email.value;
	    		query={
	 				mid:mid,
	 				moveFlag:email
	    		}
    		}
    		
    		else if(no==2) {
    			moveUrl=myform.moveUrl.value;
	    		query={
	 				moveFlag:moveUrl
	    		}
    		}
    	
    		
    		$.ajax({
    			type:"post",
    			url:"${ctp}/study/qrCode",
    			data:query,
    			success:function(res) {
    				alert("QR 코드 생성 성공! 이름은? "+res);
    				$("#qrCodeView").show();
    				$("#qrView").html(res);

    				let qrImage='<img src="${ctp}/data/qrCode/'+res+'.png" />';
    				
    				$("#qrImage").html(qrImage);
    			},
    			error:function() {
    				alert("전송 오류!");
    			}
    		});
    		
    	}
    	
    	function qrCreateDB() {
    		let newsHref=myform.newsHref.value;
    		let mid='${sMid}';
    		let nickName='${sNickName}';
    		
    		let query={
    				mid:mid,
    				nickName:nickName,
    				bigo:newsHref
    		}
    		
    		$.ajax({
    			type:"post",
    			url:"${ctp}/study/qrCodeDB",
    			data:query,
    			success:function(res) {
    				alert("QR 코드 생성 성공! 이름은? "+res);
    				$("#qrCodeView").show();
    				$("#qrView").html(res);
    				
    				let strUid=res.substring(res.lastIndexOf('_') + 1);
    				
    				let qrLink='<a href="http://192.168.50.65:9090/javawspring/study/qrCodeRes?idx='+strUid+'">생성결과 바로가기</a>';
    				
    				$("#qrLink").html(qrLink);
    				
    				let qrImage='<img src="${ctp}/data/qrCode/'+res+'.png" />';
    				
    				$("#qrImage").html(qrImage);
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
	<form name="myform">
		<h2>QR 코드 생성 연습</h2>
		<p>
			<b>개인정보 입력</b> : <br/>
			아이디 : <input type="text" name="mid" value="${vo.mid}" class="form-control" /><br/>
			이메일 : <input type="text" name="email" value="${vo.email}" class="form-control" /><br/>
			<input type="button" value="신상 정보 QR 코드 생성" onclick="qrCreate(1)" class="btn btn-success">
		</p>
		<hr/>
	
		<h4>소개하고 싶은 사이트 주소를 입력하세요!</h4>
		
		<p>
			이동할 주소 : <input type="text" name="moveUrl" value="https://github.com/develop00bazzi" class="form-control" /><br/>
			<input type="button" value="URL QR 코드 생성" onclick="qrCreate(2)" class="btn btn-primary">
		</p>
		
		<h4>${sNickName}님이 좋아하는 뉴스 주제는?</h4>
		
		<select name="newsHref" class="form-control">
			<option>정치</option>
			<option>경제</option>
			<option>사회</option>
			<option>생활 / 문화</option>
			<option>IT / 과학</option>
			<option>세계</option>
			<option>랭킹</option>
			<option>신문 보기</option>
			<option>오피니언</option>
			<option>TV</option>
			<option>팩트체크</option>
		</select>
		<br/>
		<p><input type="button" value="내가 선택한 뉴스 주제 바로가기" onclick="qrCreateDB()" class="btn btn-primary"></p>
		
		<hr/>
		<div id="qrCodeView" style="display: none;">
			<h2>생성된 QR코드 확인하기</h2>
			<div>
				- 생성된 QR 코드명 : <span id="qrView"></span><br/>
				- 바로가기 : <span id="qrLink"></span><br/>
				<span id="qrImage"></span>
			</div>
		</div>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>