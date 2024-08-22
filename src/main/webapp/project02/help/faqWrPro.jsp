<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>   
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.FaqDTO" />
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="dao" class="web.bean.dao.FaqDAO" />

<%
  int result = dao.faqAdd(dto);

  if(result==1){ %>
  <script>
   alert("FAQ 등록완료");
   window.location="faqList.jsp";
   </script>
   
<% } else{%>
  <script>
   alert("등록안됨");
   history.go(-1);
   </script>
<% }%>