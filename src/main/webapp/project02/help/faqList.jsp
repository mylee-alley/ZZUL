<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="web.bean.dto.FaqDTO" %> 
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.FaqDAO"/> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<h1>FAQ</h1>

<table  width="600" >
   <td align="right" >
<%
  String sid = (String)session.getAttribute("sid");
  if(sid != null && sid.equals("admin")){//관리자 로그인일때%>
     <a href="faqWrite.jsp">FAQ 쓰기</a>
<%}else{}%>
   </td> 
</table>

<table border="1" width="600">
<b>자주하는 질문</b>
</table>

<table class="table table-hover">
<% 
 List faqList = dao.faqlist();
  for(int x=0 ; x < faqList.size() ; x++ ){
  FaqDTO dto = (FaqDTO)faqList.get(x);%>
   <tr><td>
   <a href="faqAnswer.jsp?faqNum=<%=dto.getFaqNum()%>"><%=dto.getQuestion()%></a>
   </td></tr>
<% } %>
</table>   