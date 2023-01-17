<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberLogin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		'use strict'
		
		// 자바 스크립트 앱키 설정
		
		window.Kakao.init("5b97ef649f5d9df28ecf21280488505c");
		
		// 카카오 로그인
		
		function loginWithKakao() {
			window.Kakao.Auth.login({
				scope:'profile_nickname, account_email',
				success:function(autoObj) {
					console.log(autoObj);
					window.Kakao.API.request({
						url:'/v2/user/me',
						success:function(res) {
							const kakao_account=res.kakao_account;
							console.log(kakao_account);
							console.log(Kakao.Auth.getAccessToken(), "로그인");
							// alert(kakao_account.email+"/"+kakao_account.profile.nickname);
							// alert(JSON.stringify(kakao_account));
							
							location.href="${ctp}/member/memberKakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email;
							
						}
					});
				}
			});
		}
		
		// 카카오 로그아웃
		
		// 현재 사용한 함수는 세션만 끊어주는 상태인데 완벽하게 로그인 상태를 해제하려면 어떻게 해야하는지 찾아보기
		
		function kakaoLogout(kakaoKey) {
			window.Kakao.Auth.logout(function() {
				console.log(Kakao.Auth.getAccessToken(), "토큰 정보가 없습니다. (로그아웃되셨습니다!)");
			});
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="container" style="padding:30px">
			  <form name="myform" method="post" class="was-validated">
			    <h2>회원 로그인</h2>
			    <p>회원 아이디와 비밀번호를 입력해 주세요</p>
			    <div class="form-group">
			      <label for="mid">회원 아이디 :</label>
			      <input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus />
			      <div class="valid-feedback">입력성공!!</div>
			      <div class="invalid-feedback">회원 아이디는 필수 입력사항입니다.</div>
			    </div>
			    <div class="form-group">
			      <label for="pwd">비밀번호 :</label>
			      <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
			      <div class="invalid-feedback">회원 비밀번호는 필수 입력사항입니다.</div>
			    </div>
			    <div class="form-group text-center">
				    <button type="submit" class="btn btn-primary">로그인</button>
				    <button type="reset" class="btn btn-primary">다시입력</button>
				    <button type="button" onclick="location.href='${ctp}/';" class="btn btn-primary">돌아가기</button>
				    <button type="button" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary">회원가입</button>
			    </div>
			    <div class="text-center mb-3">
			    	<a id="kakao-login-btn" href="javascript:loginWithKakao()">
					  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="200"
					    alt="카카오 로그인 버튼" />
					</a>
					<a href="javascript:kakaoLogout()" class="btn btn-danger">로그아웃</a>
			    </div>
			    <div class="row" style="font-size:12px">
			      <span class="col"><input type="checkbox" name="idCheck" checked /> 아이디 저장</span>
			      <span class="col">
			        [<a href="${ctp}/member/memberMidSearch">아이디찾기</a>] /
			        [<a href="#">비밀번호찾기</a>]
			      </span>
			    </div>
			  </form>
		  </div>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>