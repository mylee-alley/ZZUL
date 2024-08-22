<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
   <jsp:useBean id="dto" class="web.bean.dto.MenuDTO" />
   <jsp:setProperty property="*" name="dto"/>
   <jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
   
   <%
      
      dao.menuUpdate(dto);
      
   
   %>
   <script>
   alert("수정 되었습니다.");
   window.location="menuList.jsp";
   </script>