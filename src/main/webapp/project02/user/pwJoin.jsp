<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />

<form action="pwJoinPro.jsp">
이름 : <input type="text" name="name" > </br>
전화번호 :	<input type="number" name="phone" >
  		<input type="submit" value="찾기">
</form>