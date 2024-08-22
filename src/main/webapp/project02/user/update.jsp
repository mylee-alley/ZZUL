<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />

<%
	String id = (String)session.getAttribute("sid");
	dto = dao.member(id);
%>

<form action="updatePro.jsp" method="post" onsubmit="return validateForm()">
    id : <%=id %>    
    <input type="hidden" name="id" value="<%=id%>" > <br/>
    이름 : <input type="text" name="name" value="<%=dto.getName()%>" required minlength="6"><br/>
    전화번호 : <input type="tel" name="phone" value="<%=dto.getPhone()%>" required pattern="[0-9]{10,}" ><br/>
    이메일 : <input type="email" name="email" value="<%=dto.getEmail()%>" required minlength="6"> <br/>
    <input type="submit" value="정보 수정"/>    
</form>
