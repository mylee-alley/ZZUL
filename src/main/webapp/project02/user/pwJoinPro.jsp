<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
	<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />
   <%
   String name = request.getParameter("name");
   String phone = request.getParameter("phone");
   
   	dto = dao.memberJoin(name, phone);
   	

    if (dto == null || dto.getPw() == null) {		//이 조건은 검색된 dto개체가 null인지 또는 해당 개체의 ID가 null인지 확인한다.
												//두 조건 중 하나가 true이면 데이터베이스에서 일치하는 멤버를 찾을 수 없음을 의미한다.
%>
    <script>
        alert("입력하신 정보와 일치하는 비밀번호가 없습니다.");				
        history.go(-1); // 바로 전 페이지로 이동
    </script>
<%
    } else {
        
%>

    <form action="login.jsp" method="post">
        <h4>찾으신 비밀번호는 : <%=dto.getPw() %>입니다</h4><br/>
        <input type="submit" value="로그인하기"/>
    </form>

<%
    }
%>