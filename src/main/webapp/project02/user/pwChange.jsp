<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO"></jsp:useBean>   
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO"/> 
    
 <form action="pwChangePro.jsp" method="post"> 
기존 비밀번호 :	<input type="password" name="pw" > <br />	
변경	비밀번호 : <input type="password" name="newPw" /><br />	
비밀번호 확인 : <input type="password" name="oidPw" ><br />	
		   	 <input type="submit" value="비밀번호 변경">
</form>   
    
    