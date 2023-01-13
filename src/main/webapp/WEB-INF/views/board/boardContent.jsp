<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>boContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		// 전체 댓글 보이기 / 가리기 처리
		
		$(document).ready(function() {
			$("#reply").show();
			$("#replyViewBtn").hide();
			
			$("#replyHiddenBtn").click(function() {
				$("#reply").slideUp(500);
				$("#replyViewBtn").show();
				$("#replyHiddenBtn").hide();
			});
			
			$("#replyViewBtn").click(function() {
				$("#reply").slideDown(500);
				$("#replyHiddenBtn").show();
				$("#replyViewBtn").hide();
			});
		});
		
		// DB 좋아요
		
		function dbLike() {
			
			$.ajax({
				type: "post",
				url: "${ctp}/board/dbLike",
				data: {
					idx:${vo.idx},
					mid:'${sMid}',
					part:'board'
					},
				success: function(res) {
						location.reload();
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		// 좋아요 확인
		
		function clickLike() {
			$.ajax({
				type: "post",
				url: "${ctp}/board/clickLike",
				data: {idx:${vo.idx}},
				success: function(res) {
					if(res=="1") {
						location.reload();
					}
					else {
						alert("이미 좋아요를 한번 누르셨습니다!");
						location.reload();
					}
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		// DB 좋아요 처리
		
		/* 
		
		function dbLike(sw) {
			
		}
		
		*/
		
		// 좋아요 증가
		
		/* function goodPlus() {
			$.ajax({
				type: "post",
				url: "${ctp}/boGoodPlus.bo",
				data: {idx:${vo.idx}},
				success: function() {
					location.reload();
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		} */
		
		// 좋아요 감소
		
		/* function goodMinus() {
			$.ajax({
				type: "post",
				url: "${ctp}/boGoodMinus.bo",
				data: {idx:${vo.idx}},
				success: function() {
					location.reload();
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		} */
		
		/* 게시글 삭제 처리 */
		
		function boardDelCheck() {
			let ans=confirm("현재 게시글을 삭제하시겠습니까?");
			
			if(ans) location.href="${ctp}/board/boardDeleteOk?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&mid=${vo.mid}&flag=${flag}&search=${search}&searchString=${searchString}";
		}
		
		/* 댓글 작성 등록 처리 */
		
		function replyCheck() {
			
			let content=$("#content").val();
			
			if(content.trim()=="") {
				alert("댓글을 입력하세요!");
				$("#content").focus();
				return false;
			}
			
			let query= {
					boardIdx: ${vo.idx},
					mid: '${sMid}',
					nickName: '${sNickName}',
					content: content,
					hostIp: '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type: "post",
				url: "${ctp}/board/boardReplyInput",
				data: query,
				success: function(res) {
					if(res=="1") {
						alert("댓글 입력 완료!");
						location.reload();
					}
					else {
						alert("댓글 입력 실패!");
					}
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		function replyDelCheck(idx) {
			let ans=confirm("댓글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type: "post",
				url: "${ctp}/board/boardReplyDeleteOk",
				data: {idx: idx},
				success: function(res) {
					if(res=="1") {
						alert("댓글 삭제 완료!");
						location.reload();
					}
					else {
						alert("댓글 삭제 실패!");
					}
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		
		// 답변글 대댓글
		
		function insertReply(idx, level, levelOrder, nickName) {
			let insReply='';
			insReply+='<div class="container">';
			insReply+='<table class="m-2 p-0" style="width:90%;">';
			insReply+='<tr>';
			insReply+='<td class="p-0 text-left">';
			insReply+='<div>';
			insReply+='<p class="mt-3">답변 댓글 달기 : &nbsp;';
			insReply+='<input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0" />';
			insReply+='</p>';
			insReply+='</div>';
			insReply+='</td>';
			insReply+='<td class="text-right">';
			insReply+='<input type="button" value="답글 달기" onclick="replyCheck2('+idx+','+level+','+levelOrder+')" />';
			insReply+='</td>';
			insReply+='</tr>';
			insReply+='<tr>';
			insReply+='<td colspan="2" class="text-center p-0">';
			insReply+='<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
			insReply+='@'+nickName+'\n';
			insReply+='</textarea>';
			insReply+='</td>';
			insReply+='</tr>';
			insReply+='</table>';
			insReply+='</div>';
			
			$("#replyBoxOpenBtn"+idx).hide();
			$("#replyBoxCloseBtn"+idx).show();
			$("#replyBox"+idx).slideDown(500);
			$("#replyBox"+idx).html(insReply);
		}
		
		function closeReply(idx) {
			$("#replyBoxOpenBtn"+idx).show();
			$("#replyBoxCloseBtn"+idx).hide();
			$("#replyBox"+idx).slideUp(500);
		}
		
		function replyCheck2(idx, level, levelOrder) {
			let boardIdx="${vo.idx}";
			let mid="${sMid}";
			let nickName="${sNickName}";
			
			// let content="content"+idx;
			// let contentVal=$(content).val();
			
			let content=$("#content"+idx).val();
			let hostIp="${pageContext.request.remoteAddr}";
			
			if(content=="") {
				alert("답변글(대댓글)을 입력하세요!");
				$("#content"+idx).focus();
				return false;
			}
			
			let query= {
					idx:idx,
					boardIdx: boardIdx,
					mid: mid,
					nickName: nickName,
					content: content,
					hostIp: hostIp,
					level: level,
					levelOrder: levelOrder
			}
			
			$.ajax({
				type: "post",
				url: "${ctp}/board/boardReplyInput2",
				data: query,
				success:function() {
					alert("답글이 작성되었습니다!");
					location.reload();
				},
				error: function() {
					alert("전송 오류!");
				}
			});
			
		}
		
		// 댓글 수정하기
		
		function replyUpdateCheck(idx, content) {
			
			let updateReply='';
			
			updateReply+='<div class="container">';
			updateReply+='<table class="m-2 p-0" style="width:90%;">';
			updateReply+='<tr>';
			updateReply+='<td class="p-0 text-left">';
			updateReply+='<div>';
			updateReply+='<p class="mt-3">댓글 수정 : &nbsp;';
			updateReply+='<input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0" />';
			updateReply+='</p>';
			updateReply+='</div>';
			updateReply+='</td>';
			updateReply+='<td class="text-right">';
			updateReply+='<input type="button" value="수정" onclick="replyUpdate('+idx+')" />';
			updateReply+='</td>';
			updateReply+='</tr>';
			updateReply+='<tr>';
			updateReply+='<td colspan="2" class="text-center p-0">';
			updateReply+='<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
			updateReply+=content.replaceAll('<br/>','\n');
			updateReply+='</textarea>';
			updateReply+='</td>';
			updateReply+='</tr>';
			updateReply+='</table>';
			updateReply+='</div>';
			
			$("#replyUpdateOpenBtn"+idx).hide();
			$("#replyUpdateCloseBtn"+idx).show();
			$("#replyBox"+idx).slideDown(500);
			$("#replyBox"+idx).html(updateReply);
		}
		
		// 댓글 수정 폼 닫기
		
		function replyUpdateClose(idx) {
			$("#replyUpdateOpenBtn"+idx).show();
			$("#replyUpdateCloseBtn"+idx).hide();
			$("#replyBox"+idx).slideUp(500);
		}
		
		// 댓글 수정 처리
		
		function replyUpdate(idx) {
			
			let content=$("#content"+idx).val();
			let hostIp="${pageContext.request.remoteAddr}";
			
			if(content=="") {
				alert("수정할 내용이 없습니다!");
				$("#content"+idx).focus();
				return false;
			}
			
			let query={
					idx:idx,
					content:content,
					hostIp:hostIp
			}
			
			$.ajax({
				type: "post",
				url: "${ctp}/board/boardReplyUpdate",
				data: query,
				success:function() {
					alert("댓글이 수정되었습니다!");
					location.reload();
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
	<h2>글 내용 보기</h2>
	<br/>
	<table class="table table-bordered">
		<tr>
			<td>접속된 IP: ${vo.hostIp}</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>작성일자</th>
			<td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
		</tr>
		<tr>
			<th>글 제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th>이메일 주소</th>
			<td>${vo.email}</td>
			<th>조회수</th>
			<td>${vo.readNum}</td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td>${vo.homePage}</td>
			<th>좋아요</th>
			<%-- <td><c:if test=""></c:if>
				<a href="javascript:goodCheck()" id="good">
					<font color="
					<c:if test="${fn:contains(color,vo.idx) && fn:contains(color,'red')}">red</c:if>
					<c:if test="${fn:contains(color,vo.idx) && fn:contains(color,'black')}">black</c:if>
					">❤</font>
				</a> ${vo.good} &nbsp;       
				<a href="javascript:goodPlus()">👍</a>
				<a href="javascript:goodMinus()">👎</a>
			</td> --%>
			<td>
			<a href="javascript:clickLike()">
	           	<c:if test="${sSw == '1'}"><font color="red">❤</font></c:if>
				<c:if test="${sSw != '1'}">❤</c:if>
			</a>
			${vo.good}
			<a href="javascript:dbLike()">
				<c:if test="${!empty goodVO}"><font color="red">GOOD</font></c:if>
           		<c:if test="${empty goodVO}">GOOD</c:if>
			</a>
			</td>
		</tr>
		<tr>
			<th>글 내용</th>
			<td colspan="3" style="height: 250px;">${fn:replace(vo.content,newLine,'<br/>')}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<%-- <c:if test="${flag=='search'}"> --%>
					<%-- <input type="button" value="돌아가기" onclick="location.href='${ctp}/boSearch.bo?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary" /> --%>
				<%-- </c:if> --%>
				<%-- <c:if test="${flag!='search'}"> --%>
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}&flag=${flag}&search=${search}&searchString=${searchString}';" class="btn btn-secondary" />
					<c:if test="${(sMid eq vo.mid) || (sLevel=='0')}">
						<input type="button" value="글 수정" onclick="location.href='${ctp}/board/boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary" />
						<input type="button" value="글 삭제" onclick="boardDelCheck()" class="btn btn-secondary" />
					</c:if>
				<%-- </c:if> --%>
			</td>
		</tr>
	</table>
	
	<!-- 댓글(대댓글) 처리 -->
	
	<div class="text-center mb-3">
		<input type="button" value="댓글 보이기" id="replyViewBtn" class="btn btn-primary" />
		<input type="button" value="댓글 가리기" id="replyHiddenBtn" class="btn btn-danger" />
	</div>
	
	<!-- 댓글 내용 보여주기 처리 -->
	<div id="reply">
		<table class="table table-hover text-center">
			<tr style="background-color: #eee;">
				<th class="text-center">작성자</th>
				<th class="text-center">내용</th>
				<th class="text-center">작성일자</th>
				<th class="text-center">접속 IP</th>
				<th class="text-center">답글</th>
			</tr>
			<c:forEach var="replyVO" items="${replyVOS}">
				<tr>
					<td class="text-left">
						<c:if test="${replyVO.level<=0}">${replyVO.nickName}</c:if>
						<c:if test="${replyVO.level>0}">
							<c:forEach var="i" begin="1" end="${replyVO.level}">&nbsp;&nbsp;</c:forEach>
							L ${replyVO.nickName}
						</c:if>
						<c:if test="${sMid==replyVO.mid||sLevel==0}">
							<a href="javascript:replyDelCheck(${replyVO.idx})" class="badge badge-primary" title="삭제하기">삭제</a>
							<a href="javascript:replyUpdateCheck('${replyVO.idx}','${fn:replace(replyVO.content,newLine,'<br/>')}')" id="replyUpdateOpenBtn${replyVO.idx}" class="badge badge-info" title="수정하기">수정</a>
							<a href="javascript:replyUpdateClose('${replyVO.idx}')" id="replyUpdateCloseBtn${replyVO.idx}" class="badge badge-info" title="수정하기" style="display: none;">닫기</a>
						</c:if>
					</td>
					<td class="text-center">
						${fn:replace(replyVO.content,newLine,'<br/>')}
					</td>
					<td class="text-center">${fn:substring(replyVO.WDate,0,19)}</td>
					<td class="text-center">${replyVO.hostIp}</td>
					<td class="text-center">
						<input type="button" value="답글" onclick="insertReply('${replyVO.idx}','${replyVO.level}','${replyVO.levelOrder}','${replyVO.nickName}')" id="replyBoxOpenBtn${replyVO.idx}" class="btn btn-sm btn-secondary" />
						<input type="button" value="닫기" onclick="closeReply('${replyVO.idx}')" id="replyBoxCloseBtn${replyVO.idx}" class="btn btn-sm btn-info" style="display: none;" />
					</td>
				</tr>
				<tr>
					<td colspan="5" class="m-0 p-0" style="border-top: none;">
						<div id="replyBox${replyVO.idx}"></div>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 댓글 입력창 처리 -->
	
		<!-- <form name="replyForm" method="post" action=${ctp}/boReplyInput.bo"> -->
		<form name="replyForm">
			<table class="table text-center">
				<tr>
					<td style="width:85%;" class="text-left">
						<!-- 글내용: -->
						<textarea rows="4" name="content" id="content" class="form-control"></textarea>
					</td>
					<td style="width:15%;">
						<br/>
						<p>작성자: ${sNickName}</p>
						<p>
							<input type="button" value="댓글 입력" onclick="replyCheck()" class="btn btn-secondary btn-sm" />
						</p>
					</td>
				</tr>
			</table>
			<%-- <input type="hidden" name="boardIdx" value="${vo.idx}" />
			<input type="hidden" name="hostIp" value="${pageContent.request.remoteAddr}" />
			<input type="hidden" name="mid" value="${sMid}" />
			<input type="hidden" name="nickName" value="${sNickName}" /> --%>
		</form>
		
	</div>
	
	<!-- 이전 글 다음 글 처리 -->
	
	<c:if test="${flag!='search'}">
		<table class="table table-borderless">
			<tr>
				<td class="text-center">
					<%-- <c:if test="${prevVO.prevIdx!=0}">
						<a href="${ctp}/board/boardContent?idx=${prevVO.prevIdx}&pag=${pag}&pageSize=${pageSize}" class="btn btn-secondary btn-sm"> 👈 이전 글: ${prevVO.prevTitle}</a>
					</c:if>
					<c:if test="${nextVO.nextIdx!=0}">
						<a href="${ctp}/board/boardContent?idx=${nextVO.nextIdx}&pag=${pag}&pageSize=${pageSize}" class="btn btn-secondary btn-sm"> 👉 다음 글: ${nextVO.nextTitle}</a>
					</c:if> --%>
					
					<c:if test="${!empty pnVOS[1]}">
						다음글: <a href="${ctp}/board/boardContent?idx=${pnVOS[1].idx}&pag=${pag}&pageSize=${pageSize}">${pnVOS[1].title}</a><br/>
					</c:if>
					<c:if test="${vo.idx < pnVOS[0].idx}">
						다음글: <a href="${ctp}/board/boardContent?idx=${pnVOS[0].idx}&pag=${pag}&pageSize=${pageSize}">${pnVOS[0].title}</a><br/>
					</c:if>
					
					<c:if test="${vo.idx > pnVOS[0].idx}">
						이전글: <a href="${ctp}/board/boardContent?idx=${pnVOS[0].idx}&pag=${pag}&pageSize=${pageSize}">${pnVOS[0].title}</a><br/>
					</c:if>
					
					<%-- <a href="${ctp}/board/boardContent?idx=${nextVO.nextIdx}&pag=${pag}&pageSize=${pageSize}" class="btn btn-secondary btn-sm"> 👉 다음 글: ${nextVO.nextTitle}</a> --%>
				</td>
			</tr>
		</table>
	</c:if>
	
		
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
<script	src="${ctp}/js/slideShow.js" type="text/javascript"></script>
<script	src="${ctp}/js/smallMenu.js" type="text/javascript"></script>
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script>
</body>
</html>