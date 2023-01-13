<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>mailForm.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	th {
    		text-align:center;
    		background-color: #eee;
    	}	
    </style>
    <script>
    	'use strict';
    	
    	function addEmail() {
    		let email=$("#emailList").val();
    		$("#toMail").val(email);
    	}
    		
    		
    	function jusorokList() {
    		$("#myModal").on("show.bs.modal", function(e){
    			$(".modal-header #cnt").html(${cnt});
    			
    			let jusorok = '';
        		jusorok += '<table class="table table-hover">';
        		jusorok += '<tr class="table-dark text-dark text-center">';
        		jusorok += '<th>번호</th><th>아이디</th><th>성명</th><th>메일주소</th>';
        		jusorok += '</tr>';
        		jusorok += '<c:forEach var="vo" items="${vos}" varStatus="st">';
        		jusorok += '<tr onclick="location.href=\'${ctp}/study/mail/mailForm?email=${vo.email}\'" class="text-center">';
        		jusorok += '<td>${st.count}</td>';
        		jusorok += '<td>${vo.mid}</td>';
        		jusorok += '<td>${vo.name}</td>';
        		jusorok += '<td>${vo.email}</td>';
        		jusorok += '</tr>';
        		jusorok += '</c:forEach>';
        		jusorok += '';
        		jusorok += '</table>';
    			
    			$(".modal-body #jusorok").html(jusorok);
    		});
    	}
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">

	<h2 class="text-center">메 일 보 내 기 연 습</h2>
	<p> 받는 사람의 메일 주소를 정확히 입력하셔야 합니다!</p>
	<form name="myform" method="post">
		<table class="table table-bordered">
			<tr>
				<th class="align-middle">회원 이메일 주소</th>
				<td>
					<select name="emailList" id="emailList" class="form-control" onchange="addEmail()">
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<option>${vo.email}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th class="align-middle">받는 사람</th>
				<td>	
					<div class="row">
						<div class="col-10"><input type="text" name="toMail" id="toMail" value="" placeholder="받는 사람의 이메일 주소를 입력하세요!" class="form-control" required/></div>
						<div class="col-2"><input type="button" value="이메일 리스트" onclick="jusorokList()" class="btn btn-primary form-control" data-toggle="modal" data-target="#myModal" /></div>
					</div>
				</td>
			</tr>
			<tr>
				<th class="align-middle">메일 제목</th>
				<td><input type="text" name="title" placeholder="메일의 제목을 입력해주세요!" class="form-control" required /></td>
			</tr>
			<tr>
				<th class="align-middle">메일 내용</th>
				<td><textarea rows="7" name="content" class="form-control" required ></textarea></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" value="메일 전송" class="btn btn-secondary" />
					<input type="reset" value="다시 작성" class="btn btn-secondary" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-secondary" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>


<!-- 이메일 리스트를 Modal로 출력하기 -->

<div class="modal fade" id="myModal" style="width: 680px;">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 600px">
			<div class="modal-header" style="width: 600px">
				<h4 class="modal-title">이메일 리스트 총 <span id="cnt"></span>건</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body" style="width: 600px; height: 500px; overflow: auto;">
				<span id="jusorok"></span>
			</div>
			<div class="modal-footer" style="width: 600px">
				<button type="button" class="close btn-danger" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
</body>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</html>