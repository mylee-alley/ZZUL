<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
%>
<h1>메뉴 이미지 등록</h1>
<form action="imgPro.jsp" method="post" encType="multipart/form-data">
	<input type="hidden" name="num" value="<%=num%>"/>
	사진 : <input type="file" name="img" /><br/><br/>
			<input type="submit" value="등록">
</form>