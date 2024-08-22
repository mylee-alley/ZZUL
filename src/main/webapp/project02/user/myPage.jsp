<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>마이페이지</h1>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />

<%
	String id =(String)session.getAttribute("sid");
	dto= dao.member(id);
%>
 <h4>아이디 : <%=dto.getId() %></h4>
 <h4>이름 : <%=dto.getName() %></h4>
 <h4>전화번호 : <%=dto.getPhone() %></h4>
 <h4>이메일 : <%=dto.getEmail() %></h4>
 <h4>가입일시 : <%=dto.getReg_date() %></h4>
 <h4>예약횟수 : <%=dto.getBook_count() %></h4>

<a href="update.jsp">정보수정</a>
<a href="delete.jsp">회원탈퇴</a>