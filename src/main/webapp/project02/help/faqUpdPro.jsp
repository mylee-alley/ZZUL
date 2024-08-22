<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<jsp:useBean id="dao" class="web.bean.dao.FaqDAO"/> 
<jsp:useBean id="dto" class="web.bean.dto.FaqDTO"/> 
<jsp:setProperty property="*" name="dto"/>  
  
<%
  int result = dao.faqUpdate(dto);

  if(result==1){ %>
  <script>
   alert("수정 되었습니다.");
   window.location="faqList.jsp";
   </script>
   
<% } else{%>
  <script>
   alert("수정안됨");
   history.go(-1);
   </script>
<% }%>
   