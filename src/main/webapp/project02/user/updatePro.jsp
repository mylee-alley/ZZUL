<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); // port방식 인코딩 %>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:setProperty  name="dto"	property="*"/>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />
	
<%
	 dao.memberUpdate(dto);
%>	
<script >
	alert("수정 되었습니다.");
	window.location="myPage.jsp";	
</script>
    