<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 

<title>
게시글 작성화면
</title>


<!-- include libraries(jquery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<!-- cdn 변경 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>

  <style>
  
  #title{
  width: 990px;
  }
  #main-wrap{

  }
  
  </style>


     <div class="gnb-wrap">
               <a href="${contextPath}/main.page"> 메인으로 돌아가기 </a>
     </div>
     
 <div id="main-wrap">
 <h1 class="title">게시글 작성화면</h1>
 
 
 <form id="frm-board-register"
       method="POST"
       enctype="multipart/form-data"
       action = "${contextPath}/board/register.do">
       
 <div>
  <span>작성자</span>
  <span>${sessionScope.user.email}</span>
 </div>
 
 <div>
  <label for="title">제목</label>
  <input type="text" name="title" id="title">
 </div>      
 
 <div>
  <textarea id="contents" name="contents" placeholder="내용을 입력하세요"></textarea>
 </div>
 
 <div>
  <label for="files">첨부</label>
  <input type="file" name="files" id="files" multiple>
 </div>
 
 <div id="attach-list">첨부파일목록</div>
 
 <div>
 <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
 <button type="submit">작성완료</button>
 <a href="${contextPath}/board/list.do"><button type="button">작성취소</button></a>
 </div>
 
 </form>
 
</div> 
 
<script>

$(document).ready(function(){  
	  $('#contents').summernote({
	    width: 1024,
	    height: 500,
	    lang:'ko-KR',
	    callbacks: {
	      onImageUpload: (images)=>{
	        for(let i = 0; i < images.length; i++){
	          let formData = new FormData();  
	          formData.append('image',images[i]);
	          fetch('${contextPath}/summernote/imageUpload.do', {
	            method: 'POST',
	            body: formData
	        
	          }).then(response=>response.json())
	          .then(resData=>{
	            $('#contents').summernote('insertImage', resData.src);
	          });
	        }
	      }     
	    }
	  });
	  })

//제목 필수 입력 스크립트
const fnRegisterUpload = () => {
  document.getElementById('frm-upload-register').addEventListener('submit', (evt) => {
    if(document.getElementById('title').value === '') {
      alert('제목은 필수입니다.');
      evt.preventDefault();
      return;
    }
  })
}
 
// 크기 제한 스크립트 + 첨부 목록 출력 스크립트
const fnAttachCheck = () => {
  document.getElementById('files').addEventListener('change', (evt) => {
    const limitPerSize = 1024 * 1024 * 10;
    const limitTotalSize = 1024 * 1024 * 100;
    let totalSize = 0;
    const files = evt.target.files;
    const attachList = document.getElementById('attach-list');
    attachList.innerHTML = '';
    for(let i = 0; i < files.length; i++){
      if(files[i].size > limitPerSize){
        alert('각 첨부 파일의 최대 크기는 10MB입니다.');
        evt.target.value = '';
        attachList.innerHTML = '';
        return;
      }
      totalSize += files[i].size;
      if(totalSize > limitTotalSize){
        alert('전체 첨부 파일의 최대 크기는 100MB입니다.');
        evt.target.value = '';
        attachList.innerHTML = '';
        return;
      }
      attachList.innerHTML += '<div>' + files[i].name + '</div>';
    }
  })
}

fnAttachCheck();
fnRegisterUpload();
</script>
 

 



        
</body>
</html>