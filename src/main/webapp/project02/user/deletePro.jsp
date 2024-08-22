<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO"></jsp:useBean>   
<%
	String id = (String)session.getAttribute("sid");
	String pw = request.getParameter("pw");
	int result = dao.memberDelete(id, pw);
	if(result == 1){
		session.invalidate();
 %>         
 <script>
	alert("탈퇴 되었습니다");
	window.location="/project/project02/home.jsp";
</script>
<% }else{ %>      
<script>
	alert("비밀번호 다시 입력");
	history.go(-1);
</script>
<% } %>
    