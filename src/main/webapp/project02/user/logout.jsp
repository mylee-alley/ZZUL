<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<%
	session.invalidate();

	Cookie [] cookies = request.getCookies();
	String cid = null, cpw = null, cauto = null;
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("cid")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cpw")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cauto")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}
%>
<script>
	alert("로그아웃 되었습니다.");
	window.location="/project/project02/home.jsp";
</script>