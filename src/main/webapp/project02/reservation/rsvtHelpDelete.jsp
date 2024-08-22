<%@page import="web.bean.dao.RsvtHelpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>

<%
String sid = (String)session.getAttribute("sid");
	RsvtHelpDAO hdao = new RsvtHelpDAO();
	
	if(sid !=null && sid.equals("admin")){
		int num = Integer.parseInt(request.getParameter("num"));
		int del = Integer.parseInt(request.getParameter("num"));
		int result = hdao.helpDelete(num);
		if (result == 1){
%>			<script>
			alert("삭제되었습니다.");
			location.href="rsvtHelpList.jsp";
	   		</script>
	<%	}else{%>
		<script>
			alert("삭제 실패했습니다.");
			location.href="rsvtHelpList.jsp";
	   		</script>
<% 	}%>
<% 	}else{%>
		<script>
		alert("잘못된접근입니다.");
		location.href="rsvtHelpList.jsp";
	    </script>
	<%}

%>