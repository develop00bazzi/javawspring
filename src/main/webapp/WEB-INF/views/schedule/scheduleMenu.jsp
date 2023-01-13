<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>scheduleMenu.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		$(document).ready(function(){
			$("#scheduleInputHidden").hide();
		});
		
		/* 일정 등록 폼을 가상에 출력하기 */
		
		function scheduleInputView() {
			$("#scheduleInputView").hide();
			$("#scheduleInputHidden").show();
		}
		
		function scheduleInputHidden() {
			$("#scheduleInputView").show();
			$("#scheduleInputHidden").hide();
		}
		
		/* 일정 등록 ajax 처리 */
		
		function scheduleInputOk() {
			let part=myform.part.value;
			let content=myform.content.value;
			if(content=="") {
				alert("일정을 입력하세요!");
				myform.content.focus();
				return false;
			}
			let query= {
					mid:'${sMid}',
					ymd: '${ymd}',
					part:part,
					content:content
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/schedule/scheduleInputOk",
				data: query,
				success: function(res) {
					if(res=="1") {
						alert("일정이 등록되었습니다!");
						location.reload();
					}
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		/* 일정 수정하기 창 모달에 띄우기 */
		
		function updateCheck(idx2,part,content,ymd) {
			
			$("#updateModal").on("show.bs.modal", function(e){
				 $(".modal-body #idx").val(idx);
				 $(".modal-body #part").val(part);
				 $(".modal-body #content").val(content);
				 
	    	});
		}
		
		/* 일정 수정 */
		
		function scheduleUpdateOk() {
			let idx=updateForm.idx.value;
			let part=updateForm.part.value;
			let content=updateForm.content.value;
			if(content=="") {
				alert("일정을 입력하세요!");
				updateForm.content.focus();
				return false;
			}
			let query= {
					idx:idx,
					part:part,
					content:content
			}
			
			$.ajax({
				type:"post",
				url:"${ctp}/schedule/scheduleUpdateOk",
				data: query,
				success: function(res) {
					if(res=="1") {
						alert("일정이 수정되었습니다!");
						location.reload();
					}
				},
				error: function() {
					alert("전송 실패!");
				}
			});
		}
		
		function delCheck(idx) {
			let ans=confirm("선택한 일정을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type: "post",
				url: "${ctp}/scheduleDeleteOk.sc",
				data: {idx:idx},
				success:function(res) {
					if(res=="1") {
						alert("선택하신 일정이 삭제되었습니다.");
						location.reload();
					}
					else {
						alert("일정 삭제 실패");
					}
				},
				error: function() {
					alert("전송 오류!");
				}
			});
		}
		
		function modalView(part,content) {
			$("#modalView").on("show.bs.modal", function(e){
				 $(".modal-body #part").html(part);
				 $(".modal-body #content").html(content);
	    	});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"></jsp:include>
<p><br/></p>
<div class="container">
	<h2 class="text-center">${ymd} 일정입니다.</h2>
	<p> 오늘의 일정은 총 ${fn:length(vos)}건 입니다.</p>
	<hr/>
	<div>
		<input type="button" value="일정등록" onclick="scheduleInputView()" id="scheduleInputView" class="btn btn-secondary" />
		<input type="button" value="일정등록창 닫기" onclick="scheduleInputHidden()" id="scheduleInputHidden" class="btn btn-primary" />
		<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
		  일정 등록(modal)
		</button>
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/schedule/schedule?yy=${fn:split(ymd,'-')[0]}&mm=${fn:split(ymd,'-')[1]-1}';" class="btn btn-secondary" /><br/>
	</div>
	<hr/>
	<c:if test="${scheduleCnt!=0}">
		<table class="table table-hover text-center">
			<tr classs="table-dark text-dark">
				<th>번호</th>
				<th>미리보기</th>
				<th>분류</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${st.count}</td>
					<td>
						<a href="#" onclick="modalView('${vo.part}','${fn:replace(vo.content,newLine,'<br/>')}')" data-toggle="modal" data-target="#modalView">
							<c:if test="${fn:indexOf(vo.content,newLine)!=-1}">
								${fn:substring(vo.content,0,fn:indexOf(vo.content,newLine))}
							</c:if>
							<c:if test="${fn:indexOf(vo.content,newLine)==-1}">
								${fn:substring(vo.content,0,21)}
							</c:if>
						</a>
					</td>
					<td>${vo.part}</td>
					<td>
						<button type="button" class="btn btn-sm btn-secondary" onclick="updateCheck('${vo.idx}','${vo.part}','${vo.content}')" data-toggle="modal" data-target="#updateModal">
							수정
						</button>
						<input type="button" value="삭제" onclick="delCheck(${vo.idx})" class="btn btn-secondary btn-sm" />
						<input type="button" value="닫기" class="btn btn-secondary btn-sm" />
						<%-- <input type="button" value="모달로 수정" onclick="updateCheck('${vo.idx}','${vo.part}','${vo.content}','${vo.ymd}')" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#updateModal"/> --%>
					</td>
				</tr>
			</c:forEach>
			<tr><td colspan="4" class="m-0 p-0"></td></tr>
		</table>
	</c:if>
</div>

<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일정 등록하기</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<form name="myform">
      		<table class="table table-bordered">
      			<tr>
      				<th>일정 분류</th>
      				<td>
      					<select name="part" class="form-control">
      						<option value="모임">모임</option>
      						<option value="업무">업무</option>
      						<option value="학습">학습</option>
      						<option value="여행">여행</option>
      						<option value="기타">기타</option>
      					</select>
      				</td>
      			</tr>
      			<tr>
      				<th>상세 일정</th>
      				<td><textarea name="content" rows="4" class="form-control"></textarea></td>
      			</tr>
      			<tr>
      				<td colspan="2" class="text-center">
      					<input type="button" value="일정 등록" onclick="scheduleInputOk()" data-dismiss="modal" class="btn btn-success form-control" />
      				</td>
      			</tr>
      		</table>
      	</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="updateModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일정 수정하기</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<form name="updateForm">
      		<table class="table table-bordered">
      			<tr>
      				<th>일정 분류</th>
      				<td>
      					<select name="part" class="form-control" id="part">
      						<option value="모임" <c:if test="${part=='모임'}">selected</c:if>>모임</option>
      						<option value="업무" <c:if test="${part=='업무'}">selected</c:if>>업무</option>
      						<option value="학습" <c:if test="${part=='학습'}">selected</c:if>>학습</option>
      						<option value="여행" <c:if test="${part=='여행'}">selected</c:if>>여행</option>
      						<option value="기타" <c:if test="${part=='기타'}">selected</c:if>>기타</option>
      					</select>
      				</td>
      			</tr>
      			<tr>
      				<th>상세 일정</th>
      				<td><textarea name="content" rows="4" class="form-control" id="content" value="${content}"></textarea></td>
      			</tr>
      			<tr>
      				<td colspan="2" class="text-center">
      					<input type="button" value="일정 수정" onclick="scheduleUpdateOk()" class="btn btn-success form-control" />
      				</td>
      			</tr>
      		</table>
      		<%-- <input type="hidden" id="ymd" value="${ymd}" /> --%>
      		<input type="hidden" id="idx"/>
      	</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="modalView">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일정 상세 확인</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<form name="updateForm">
      		<table class="table table-bordered">
      			<tr>
      				<th>항목</th>
      				<td>
      					<span id="part"></span>
      				</td>
      			</tr>
      			<tr>
      				<th>상세 일정</th>
      				<td><div id="content" rows="4" class="form-control"></div></td>
      			</tr>
      		</table>
      		<%-- <input type="hidden" id="ymd" value="${ymd}" /> --%>
      		<input type="hidden" id="idx"/>
      	</form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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