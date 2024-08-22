<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.MenuDTO" />
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<%
	dao.menuInput(dto);
%>
<script>
	alert("메뉴 등록이 완료되었습니다.");
	window.location="menuList.jsp";
</script>