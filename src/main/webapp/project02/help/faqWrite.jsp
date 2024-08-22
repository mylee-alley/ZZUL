<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<h1>FAQ 작성하기</h1>

<form action="faqWrPro.jsp" name="faqW" onsubmit="return faqWsave()">
<table><tr>
<td>제목</td>
<td><textarea rows="1" cols="50" name="question"></textarea></td></tr>

<tr><td>내용</td>
<td><textarea rows="10" cols="50" name="answer"></textarea></td></tr>
</table>
<input type="submit" value="완료"/>
</form>

<script>
function faqWsave(){
   if(document.faqW.question.value==""){
     alert("제목을 입력하세요.");
     document.faqW.question.focus();
     return false;
   }
   if(document.faqW.answer.value==""){
     alert("내용을 입력하세요.");
     document.faqW.answer.focus();
     return false;
   }
 }
</script>