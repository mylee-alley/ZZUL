<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<h1>관리자 메뉴 등록</h1>
<form action="insertPro.jsp" method="post">
	메뉴이름 : <input type="text" name="name" /><br/>
	상세설명 : <input type="text" name="detail" /><br/>
	가격 : <input type="text" name="price" /><br/>
			<input type="submit" value="메뉴 등록">
</form>