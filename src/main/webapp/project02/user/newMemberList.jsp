<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="web.bean.dto.MemberDTO" %>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />
<jsp:include page="../header.jsp" flush="true"/>
<center><h1>신규 회원 목록</h1></center>
<% List memberList = dao.getNewMembers();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
<table border="1" cellpadding="0" cellspacing="0" align="center">
	<tr height="30">
		<td align="center" width="150">ID</td>
		<td align="center" width="100">이름</td>
		<td align="center" width="150">전화번호</td>
		<td align="center" width="200">이메일</td>
		<td align="center" width="150">가입일</td>
		<td align="center" width="150">이용가능 여부</td>
		<td align="center" width="150">누적 예약 횟수</td>
		<td align="center" width="150">회원 등급</td>
	</tr>
</table>
<%
	for(int i =0; i<memberList.size(); i++){
		MemberDTO dto = (MemberDTO)memberList.get(i);
%>
<table border="1" cellpadding="0" cellspacing="0" align="center">
	<tr height="30">
		<td align="center" width="150"><%=dto.getId() %></td>
		<td align="center" width="100"><%=dto.getName() %></td>
		<td align="center" width="150"><%=dto.getPhone() %></td>
		<td align="center" width="200"><%=dto.getEmail() %></td>
		<td align="center" width="150"><%=sdf.format(dto.getReg_date()) %></td>
			<% int active=dto.getActive(); 
				if(active==0){%>
					<td align="center" width="150">이용 불가</td>
				<% }else{ %>
					<td align="center" width="150">이용 가능</td>	
				<% } %>
		<td align="center" width="150"><%=dto.getBook_count() %>회</td>
			<% int grade=dto.getUser_grade(); 
				if(grade==0){%>
					<td align="center" width="150">Family</td>
				<% }else if(grade==1){ %>
					<td align="center" width="150">Gold</td>
				<%}else if(grade==2){ %>
					<td align="center" width="150">Diamond</td>
				<%}else{ %>
					<td align="center" width="150">Company</td>
				<% } %>
	</tr>
</table>
<% } %>		