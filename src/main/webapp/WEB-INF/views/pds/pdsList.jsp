<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>pdsList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
	<script>
		'use strict';
		
		/* 분류 구분해서 출력 */
		
		function partCheck() {
			let part=partForm.part.value;
			location.href="${ctp}/pds/pdsList?part="+part+"&pageSize=${pageSize}&flag=${flag}&search=${search}&searchString=${searchString}";
		}
		
		/* 한 페이지에 몇개 보여줄지 */
		
		function pCheck() {
			let pageSize=document.getElementById("pageSize").value;
			location.href="${ctp}/pds/pdsList?part=${part}&pageSize="+pageSize+"&flag=${flag}&search=${search}&searchString=${searchString}";
		}
		
		function searchCheck() {
			
			let searchString=$("#searchString").val();
			
			if(searchString.trim()=="") {
				alert("찾고자 하는 검색어를 입력해주세요.");
				searchForm.searchString.focus();
			}
			else {
				searchForm.submit();
			}
			
		}
		
		function modalView(title,nickName,mid,part,fName,fSName,fSize,downNum,fDate) {
	    	let imgs = fSName.split("/");
	    	
	    	$("#myModal").on("show.bs.modal", function(e){
	    		$(".modal-header #title").html(title);
	    		$(".modal-header #part").html(part);
	    		$(".modal-body #nickName").html(nickName);
	    		$(".modal-body #mid").html(mid);
	    		$(".modal-body #fName").html(fName);
	    		$(".modal-body #fSize").html(fSize);
	    		$(".modal-body #downNum").html(downNum);
	    		$(".modal-body #fDate").html(fDate.substring(0,10));
	    		$(".modal-body #fSName").html(fSName);
	    		/* $(".modal-body #imgSrc").attr("src",'${ctp}/data/pds/'+imgs[0]); */
	    		// 저장된 파일에 그림이 1장이라도 있다면 1장만 화면에 출력시켜준다.
	    		$(".modal-body #imgSrc").attr("src",'');	// 기존에 존재하는 그림파일이 있으면 제거시킨다.(src값을 없앴기에 보이지 않게처리했다.)
	    		for(let i=0; i<imgs.length; i++) {
	    			let imgExt = imgs[i].substring(imgs[i].lastIndexOf(".")+1).toUpperCase();
	    			if(imgExt=="JPG" || imgExt=="GIF" || imgExt=="PNG") {
	    				$(".modal-body #imgSrc").attr("src",'${ctp}/data/pds/'+imgs[i]);
	    				break;
	    			}
	    		}
	    	});
	    }
			
		/* modal 창을 통하여 비밀번호 확인 후 파일 삭제 처리 */
		
		function pdsDelCheckModal(idx) {
			$("#myPwdModal").on("show.bs.modal", function(e){
				$(".modal-body #idx").val(idx);
			});
			
		}
		
		/* modal 창을 통해서 비밀번호 확인 후 파일을 삭제 처리 */
		
		function modalPwdDelete() {
			let pwd=pwdModalForm.pwd.value;
			let idx=pwdModalForm.idx.value;
			
			let query={
					idx: idx,
					pwd:pwd
				};
			
				
				$.ajax({
					type: "post",
					url: "${ctp}/pds/pdsDelete",
					data: query,
					success: function(res) {
						if(res=="1") {
							alert("자료가 정상적으로 삭제되었습니다.");
							location.reload();
						}
						else {
							alert("자료 삭제 실패");
						}
					},
					error: function() {
						alert("전송 오류");
					}
				});
		}
		
		/* 다운로드 횟수 증가 */
		function downNumCheck(idx) {
			$.ajax({
				type: "post",
				url: "${ctp}/pds/pdsDownNum",
				data: {idx:idx},
				success: function() {
					location.reload();
				},
				error: function() {
					alert("전송 오류");
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

	<a href="${ctp}/pds/pdsList"><h2 class="text-center">자 료 실  리 스 트 (${pageVo.part})</h2></a>
	<br/>
	
	<table class="table table-borderless">
		<tr>
			<td style="width:20%;">
				<form name="partForm">
					<select name="part" onchange="partCheck()" class="form-control">
						<option value="전체" ${pageVo.part=='전체'?'selected':''}>전체</option>
						<option value="학습" ${pageVo.part=='학습'?'selected':''}>학습</option>
						<option value="여행" ${pageVo.part=='여행'?'selected':''}>여행</option>
						<option value="음식" ${pageVo.part=='음식'?'selected':''}>음식</option>
						<option value="기타" ${pageVo.part=='기타'?'selected':''}>기타</option>
					</select>
				</form>
			</td>
			<td>
				<a href="${ctp}/pds/pdsInput?part=${part}" class="btn btn-secondary">자료 올리기</a>
			</td>
			<td style="width: 10%;" class="text-right">
				<select name="pageSize" id="pageSize" onchange="pCheck()" class="form-control">
					<option value="5" ${pageVo.pageSize==5?'selected':''}>5건</option>
					<option value="10" ${pageVo.pageSize==10?'selected':''}>10건</option>
					<option value="15" ${pageVo.pageSize==15?'selected':''}>15건</option>
					<option value="20" ${pageVo.pageSize==20?'selected':''}>20건</option>
				</select>
			</td>
		</tr>
	</table>
	
	<table class="table table-hover text-center">
		<tr>
			<th>번호</th>
			<th>자료 제목</th>
			<th>올린이</th>
			<th>작성일자</th>
			<th>분류</th>
			<th>파일명(크기)</th>
			<th>다운로드 횟수</th>
			<th>비고</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}" />
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td class="align-middle">${curScrStartNo}</td>
				<td class="align-middle">
					<c:if test="${vo.hour_diff<=24}">
						<img src="${ctp}/images/new.gif"/>
					</c:if>
					<a href="${ctp}/pds/pdsContent?part=${part}&idx=${vo.idx}&pag=${pageVo.pag}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}">
						${vo.title}
					</a>
				</td>
				<td class="align-middle">${vo.nickName}</td>
				<td class="align-middle">
					<c:if test="${vo.day_diff > 0}">
					<c:if test="${vo.hour_diff > 24}">
							${fn:substring(vo.FDate,0,10)}
						</c:if>
						<c:if test="${vo.hour_diff <= 24}">
							${fn:substring(vo.FDate,0,19)}
						</c:if>
					</c:if>
					<c:if test="${vo.day_diff <= 0}">                  
						${fn:substring(vo.FDate,11,19)}
				</c:if>
				</td>
				<td class="align-middle">${vo.part}</td>
				<td class="align-middle">
					<c:set var="fNames" value="${fn:split(vo.FName,'/')}" />
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}" />
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>					
					</c:forEach>
					<c:if test="${(vo.FSize/1024)>1024}">
						(<fmt:formatNumber value="${vo.FSize/1024/1024}" pattern="#,###" />MByte)
					</c:if>
					<c:if test="${(vo.FSize/1024)<1024 && (vo.FSize>1024)}">
						(<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,###" />KByte)
					</c:if>
					<c:if test="${vo.FSize<1024}">
						(<fmt:formatNumber value="${vo.FSize}" pattern="#,###" />Byte)
					</c:if>
				</td>
				<td class="align-middle">${vo.downNum}</td>
				<td class="align-middle">
		          <a href="#" onclick="modalView('${vo.title}','${vo.nickName}','${vo.mid}','${vo.part}','${vo.FName}','${vo.FSName}','${vo.FSize}','${vo.downNum}','${vo.FDate}')" class="badge badge-secondary" data-toggle="modal" data-target="#myModal">글 요약</a><br/>
		          <a href="${ctp}/pds/pdsTotalDown?idx=${vo.idx}" class="badge badge-secondary">전체다운</a><br/>
		          <a href="#" onclick="javascript:pdsDelCheckModal(${vo.idx})" class="badge badge-secondary" data-toggle="modal" data-target="#myPwdModal">파일 삭제</a>
		        </td>
			</tr>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
		</c:forEach>
		<tr><td colspan="8" class="m-o p-0"></td></tr>
	</table>
	
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVo.pag>1}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/pdsList?pag=1&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">첫 페이지</a></li>
			</c:if>
			<c:if test="${pageVo.curBlock>0}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/pdsList?pag=${(pageVo.curBlock-1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">이전 블록</a></li>
			</c:if>
			<c:forEach var="i" begin="${(pageVo.curBlock)*pageVo.blockSize+1}" end="${(pageVo.curBlock)*pageVo.blockSize+pageVo.blockSize}" varStatus="st">
				<c:if test="${i<=pageVo.totPage && i==pageVo.pag}">
					<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/pds/pdsList?pag=${i}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
				<c:if test="${i<=pageVo.totPage && i!=pageVo.pag}">
					<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/pdsList?pag=${i}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">${i}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${pageVo.curBlock<pageVo.lastBlock}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/pdsList?pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">다음 블록</a></li>
			</c:if>
			<c:if test="${pageVo.pag<pageVo.totPage}">
				<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pds/pdsList?pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}&flag=${pageVo.flag}&search=${pageVo.search}&searchString=${pageVo.searchString}" class="btn-sm btn-secondary">마지막 페이지</a></li>
			</c:if>
		</ul>
	</div>
	<br/>
	
	<!-- 검색기 처리 -->
	
	<div class="container text-center">
		<%-- <form name="searchForm" method="post" action="${ctp}/boSearch.bo"> --%>
		<form name="searchForm">
			<b>검색: </b>
			<select name="search">
				<option value="title">글 제목</option>
				<option value="nickName">글쓴이</option>
				<option value="content">글내용</option>
			</select>
			<input type="text" name="searchString" id="searchString" value="${pageVo.searchString}"/>
			<input type="button" value="검색" onclick="searchCheck()" class="btn btn-sm btn-secondary" />
			<input type="hidden" name="pag" value="${pageVo.pag}" />
			<input type="hidden" name="pageSize" value="${pageVo.pageSize}" />
			<input type="hidden" name="flag" value="search"/>
			<input type="hidden" name="part" value="${pageVo.part}" />
		</form>
	</div>
	
	
	
</div>

<!-- The Modal(모달창 클릭시 자료실의 내용을 모달창에 출력한다. -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <!-- Modal Header -->
	     <div class="modal-header">
	       <h4 class="modal-title"><span id="title"></span>(분류:<span id="part"></span>)</h4>
	       <button type="button" class="close" data-dismiss="modal">&times;</button>
	     </div>
	     
	     <!-- Modal body -->
	     <div class="modal-body">
	       - 올린이 : <span id="nickName"></span>
	       <hr/>
	       - 아이디 : <span id="mid"></span><br/>
	       - 파일명 : <span id="fName"></span><br/>
	       - 파일 업로드일 : <span id="fDate"></span><br/>
	       - 파일크기 : <span id="fSize"></span><br/>
	       - 파일다운횟수 : <span id="downNum"></span><br/>
	       <hr/>
	       - 저장파일명 : <span id="fSName"></span><br/>
	       <img id="imgSrc" width="350px"/><br/>
	     </div>
	     
	     <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
	
<!-- The Modal(폼태그로 비밀번호 처리하기 위한 모달창) -->
	<div class="modal fade" id="myPwdModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <!-- Modal Header -->
	     <div class="modal-header">
	       <h4 class="modal-title">자료실 게시글 삭제</h4>
	       <!-- <p>자료를 삭제하시려면 게시글의 비밀번호를 입력해주세요.</p> -->
	       <button type="button" class="close" data-dismiss="modal">&times;</button>
	     </div>
	     
	     <!-- Modal body -->
	     <div class="modal-body">
	     	<p>파일을 삭제하시려면 게시글 비밀번호를 입력해주세요!</p>
	       <form name="pwdModalForm" method="post" <%-- action="${ctp}/pdsDelete.pds" --%> class="was-validated">
	       	비밀번호:
	       	<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." class="form-control mb-2" required />
	       	<input type="button" value="삭제" onclick="modalPwdDelete()" class="btn btn-success form-control" />
	       	<input type="hidden" name="idx" id="idx" />
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
<script	src="${ctp}/js/ticketModal.js" type="text/javascript"></script></body>
</body>
</html>