<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ page import="web.bean.dao.MemberDAO" %>
<%@ page import="web.bean.dto.MemberDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="memberDAO" class="web.bean.dao.MemberDAO" />
<%
    String userid = request.getParameter("id");
	System.out.println("id:::: " +userid);
    int currentGrade = Integer.parseInt(request.getParameter("currentGrade"));
    MemberDAO member = new MemberDAO(); // 해당 사용자를 가져오는 메소드
    MemberDTO list= member.member(userid);
%>
	<h2>등급 변경</h2><hr>
	<p>아이디: <%= list.getId() %></p>
	<p>이름: <%= list.getName() %></p>
	<p>현재 등급: <%= currentGrade %></p>

<form action="gradeUpdate.jsp" method="post"> <!-- 등급을 실제로 변경할 페이지 -->
    <input type="hidden" name="userid" value="<%=list.getId() %>">
    <script>console.log(":::::" + <%=list.getId() %>);</script>
    <label>새로운 등급: </label>
    <select name="newGrade">
        <option value="0">Family</option>
        <option value="1">Gold</option>
        <option value="2">Dia</option>
        <option value="4">Company</option>
    </select><hr>
    <input type="submit" value="등급 변경" >
    <input type="button" onclick="window.close()" value="뒤로가기">
</form>
<%-- <script>
	function updateGrade() {
		<%
		try {
		    memberDAO.updateMemberGrade(list.getId(), currentGrade); // 등급 업데이트
		    out.println("<p>등급이 성공적으로 변경되었습니다.</p>");
		} catch (Exception e) {
		    out.println("<p>등급 변경에 실패했습니다.</p>");
		    e.printStackTrace(); // 디버깅을 위해 예외 출력
		}
		%>
	}
</script> --%>
