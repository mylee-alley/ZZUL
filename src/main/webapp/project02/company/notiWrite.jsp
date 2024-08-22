<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<h1>공지사항 작성</h1>

<script>
function writeSave(){
   if(document.notiW.title.value==""){
     alert("제목을 입력하세요.");
     document.notiW.title.focus();
     return false;
   }
   if(document.notiW.content.value==""){
     alert("내용을 입력하세요.");
     document.notiW.content.focus();
     return false;
   }
 }
</script>

<form action="notiWrPro.jsp" method="post" enctype="multipart/form-data" 
name="notiW" onsubmit="return writeSave()">
  
  <table border="1" width="600"><tr>
   <td align="center" width="80" >제목</td>
   <td align="left" width="520" >
   <textarea id="title" name="title" rows="1" cols="70"></textarea></td>
  </tr></table>   
  
  <table border="1" width="600"><tr>
   <td align="center" width="80" > 사진</td>
   <td align="right" width="520" ><input type="file" name="img" /></td>
  </tr></table>   

  <table border="1" width="600"><tr>
   <td align="center" width="80" >내용</td>
   <td align="left" width="520" >
   <textarea id="content" name="content" rows="10" cols="70"></textarea></td>   
  </tr></table>   
    <input type="submit" value="완료"/><br/>
</form>