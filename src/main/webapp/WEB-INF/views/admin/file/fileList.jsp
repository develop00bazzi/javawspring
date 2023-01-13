<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>fileList.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
    <style>
    	
    </style>
    <script>
    	'use strict';
    	
    	function showImages(fileName) {
    		$("#myModal").on("show.bs.modal", function(e){
    			$(".modal-title").html(fileName);
    			$(".modal-body").html("<img src='${ctp}/data/ckeditor/"+fileName+"' width='150px' />");
    		});

    	}
    	
    	// 전체선택
  	  $(function(){
  	  	$("#checkAll").click(function(){
  	  		if($("#checkAll").prop("checked")) {
  		    		$(".file").prop("checked", true);
  	  		}
  	  		else {
  		    		$(".file").prop("checked", false);
  	  		}
  	  	});
  	  });
  	  
  	  // 선택항목 반전
  	  $(function(){
  	  	$("#reverseAll").click(function(){
  	  		$(".file").prop("checked", function(){
  	  			return !$(this).prop("checked");
  	  		});
  	  	});
  	  });
    	
  	  function selectDelCheck() {
  		  let ans=confirm("선택한 사진을 삭제하시겠습니까?");
  		  
  		  if(!ans) return false;
  		  
  		  let deletePhotos="";
  		  
  		  for(let i=0; i<myform.file.length; i++) {
  			  if(myform.file[i].checked == true) deletePhotos += myform.file[i].value + "/";
  		  }
  		  
  		$.ajax({
	  		type : "post",
	  		url  : "${ctp}/admin/file/fileSelectDelete",
	  		data : {deletePhotos : deletePhotos},
	  		success:function(res) {
	  			if(res == "1") {
	  				alert("삭제 성공!");
	  			  	location.reload();
	  			}
	  		},
	  		error  :function() {
	  			alert("전송 오류!");
	  		}
	  	});
  		  
  	  }
  	  
  	  
    </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>서버 파일 리스트</h2>
	<hr/>
	<p>
		서버의 파일 경로: ${ctp}/data/ckeditor/~~~ 파일명
	</p>
	<hr/>
	<form name="myform">
		<table class="table table-bordered">
			<tr>
				<th class="text-center">ckeditor 파일 삭제</th>
			</tr>
			<tr>
				<td class="text-center">
					<input type="checkbox" id="checkAll" /> 전체선택/해제 &nbsp;&nbsp;
			        <input type="checkbox" id="reverseAll" /> 선택반전 &nbsp;&nbsp;
			        <input type="button" value="선택항목삭제" onclick="selectDelCheck()" class="btn btn-danger btn-sm"/>
				</td>
			</tr>
		</table>
		
		<table class="table table-bordered">
			<tr>
				<td class="text-center">선택</td>
				<td class="text-center">번호</td>
				<td class="text-center">파일 이름</td>
				<td class="text-center">사진</td>
			</tr>
			<c:forEach var="file" items="${files}" varStatus="st">
				<tr>
					<td>
						<c:if test="${file!='board'}">
							<input type="checkbox" name="file" id="file" class="file" value="${file}">
						</c:if>
					</td>
					<td>
						${st.count}
					</td>
					<td>
						<c:if test="${file=='board'}">${file} 폴더</c:if>
						<c:if test="${file!='board'}">
							<b>파일명:${ctp}/data/ckeditor/${file} </b>
						</c:if>
					</td>
					<td class="text-center">
						<c:if test="${file=='board'}">
							폴더
						</c:if>
						<c:if test="${file!='board' }">
							<a href="#" onclick="javascript:showImages('${file}')" class="btn btn-primary" data-toggle="modal" data-target="#myModal"/>보기</a>				
						</c:if>
					</td>
						
						<%-- <img src="${ctp}/data/ckeditor/${file}" width="150px" /><br/><hr/> --%>
				</tr>
			</c:forEach>
		
		</table>
	</form>
	
</div>
<p><br/></p>

<!-- The Modal -->
  <div class="modal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>