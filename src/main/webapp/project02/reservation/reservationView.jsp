<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<script>
const autoHyphen = (target) => {
	target.value = target.value
	.replace(/[^0-9]/g,'')
	.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/,"$1-$2-$3");
}
function idcheck(){
	alert("인증완료되셧습니다");
}
</script>
<%int i=0; %>
<form action="reservationViewPro.jsp" method="post">
	이름		<input type="text" maxlength="5" name="name"/><br />
	전화번호	<input type="text"  name="phon" oninput="autoHyphen(this)" maxlength="13"/>
			<input type="button" onclick="idcheck()" value="본인인증"/><br />
			<input type="submit" value="확인"/>
			
</form>

<a href="/project/project02/user/login.jsp">로그인</a>
<a href="/project/project02/user/input.jsp">회원가입</a>