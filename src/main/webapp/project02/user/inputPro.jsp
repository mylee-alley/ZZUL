<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.MemberDTO" %>
<%@ page import="web.bean.dao.MemberDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />

<%
	int result = dao.memberInput(dto);
	if(result == 1){
		%><script>
		   alert("회원가입이 완료되었습니다.");
		   window.location="login.jsp";
		</script><%
	} else {
		%><script>
		   alert("회원가입에 실패하였습니다");
		   window.location="input.jsp";
		</script><%
	}
%>

