<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>aJaxTest3.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function idCheck() {
    		let mid=myform.mid.value;
    		if(mid.trim()=="") {
    			alert("아이디를 입력하세요!");
    			myform.mid.focus();
    			return false;
    		}
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/ajax/aJaxTest3_1",
    			data: {mid: mid},
    			success: function(vo) {
    				let str='<b>전송 결과</b><hr/>';
    				
    				if(vo!='') {
    					str+='성명: '+vo.name+'<br/>';
    					str+='이메일: '+vo.email+'<br/>';
    					str+='홈페이지: '+vo.homePage+'<br/>';
    					str+='방문IP: '+vo.hostIp+'<br/>';
    				}
    				else {
    					str+='<font color="red"><b>찾는 자료가 없습니다!</b></font>';
    				}
    				
    				$("#demo").html(str);
    			},
    			error: function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    	
    	function nameCheck() {
    		let mid=myform.mid.value;
    		if(mid.trim()=="") {
    			alert("아이디를 입력하세요!");
    			myform.mid.focus();
    			return false;
    		}
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/ajax/aJaxTest3_2",
    			data: {mid: mid},
    			success: function(vos) {
    				let str = '<b>전송결과</b><hr/>';
        			if(vos != '') {
        				str += '<table class="table table-hover">';
        				str += '<tr class="table-dark text-dark">';
        				str += '<th>성명</th><th>이메일</th><th>홈페이지</th><th>방문IP</th>';
        				str += '</tr>';
        				for(let i=0; i<vos.length; i++) {
    	    				str += '<tr class="text-center">';
    	    				str += '<td>' + vos[i].name + '</td>';
    	    				str += '<td>' + vos[i].email + '</td>';
    	    				str += '<td>' + vos[i].homePage + '</td>';
    	    				str += '<td>' + vos[i].hostIp + '</td>';
    	    				str += '</tr>'
        				}
        				str += '</table>';
        			}
        			else {
        				str += '<font color="red"><b>찾는 자료가 없습니다.</b></font>';
        			}
        			
    				$("#demo").html(str);
    			},
    			error: function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    	
		function searchList() {
    		
    		let search=searchForm.search.value;
    		let searchString=searchForm.searchString.value;
    		
    		if(searchString.trim()=='') {
    			alert("검색하고 싶은 내용을 입력해주세요!");
    			return false;
    		}
    		
    		let query={
    			search: search,
    			searchString: searchString
    		}
    		
    		$.ajax({
    			type: "post",
    			url: "${ctp}/study/ajax/aJaxTest3_3",
    			data: query,
    			success: function(vos) {
    				let str = '<b>전송결과</b><hr/>';
        			if(vos != '') {
        				str += '<table class="table table-hover">';
        				str += '<tr class="table-dark text-dark">';
        				str += '<th>성명</th><th>이메일</th><th>홈페이지</th><th>방문IP</th>';
        				str += '</tr>';
        				for(let i=0; i<vos.length; i++) {
    	    				str += '<tr class="text-center">';
    	    				str += '<td>' + vos[i].name + '</td>';
    	    				str += '<td>' + vos[i].email + '</td>';
    	    				str += '<td>' + vos[i].homePage + '</td>';
    	    				str += '<td>' + vos[i].hostIp + '</td>';
    	    				str += '</tr>'
        				}
        				str += '</table>';
        			}
        			else {
        				str += '<font color="red"><b>찾는 자료가 없습니다.</b></font>';
        			}
        			
    				$("#demo2").html(str);
    			},
    			error: function() {
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
	<h2>aJax를 활용한 '회원 아이디' 검색하기</h2>
	<hr/>
	<form name="myform">
		<p>성명 : &nbsp; </p>
		<p>
			<input type="text" name="mid" id="mid" autofocus class="form-control"/> &nbsp;
		</p>
		<p>
			<input type="button" value="성명 일치 검색" onclick="idCheck()" class="btn btn-secondary"/> &nbsp;
			<input type="button" value="성명 부분 일치 검색" onclick="nameCheck()" class="btn btn-secondary"/> &nbsp;
			<input type="reset" value="다시 입력" class="btn btn-primary"/> &nbsp;
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/study/ajax/ajaxMenu';" class="btn btn-primary"/> &nbsp;
		</p>
		<p><span id="demo"></span></p>
	</form>
	<form name="searchForm">
		<p>검색: &nbsp;</p>
		<p>
			<select name="search">
				<option value="name">이름</option>
				<option value="email">이메일</option>
				<option value="content">내용</option>
			</select>
		</p>
		<p>
			<input type="text" name="searchString" id="searchString" autofocus class="form-control"/> &nbsp;
		</p>
		<p>
			<input type="button" value="검색" onclick="searchList()" class="btn btn-secondary"/> &nbsp;
			<input type="reset" value="다시 입력" class="btn btn-primary"/> &nbsp;
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/study/ajax/ajaxMenu';" class="btn btn-primary"/> &nbsp;
		</p>
		<p><span id="demo2"></span></p>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>