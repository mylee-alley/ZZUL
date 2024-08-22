<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />

<%
    String name = request.getParameter("name");// 파라미터로 전달받은 값
    String phone = request.getParameter("phone");	// 파라미터로 전달받은 값

    dto = dao.memberJoin(name, phone);	// 파라미터로 전달받은 값을 대입해서 메서드 호출 결과를 dto 에 저장

    if (dto == null || dto.getId() == null) {		//이 조건은 검색된 dto개체가 null인지 또는 해당 개체의 ID가 null인지 확인한다.
												//두 조건 중 하나가 true이면 데이터베이스에서 일치하는 멤버를 찾을 수 없음을 의미한다.
%>
    <script>
        alert("입력하신 정보와 일치하는 아이디가 없습니다.");				
        history.go(-1); // 바로 전 페이지로 이동
    </script>
<%
    } else {
        
%>

    <form action="login.jsp" method="post">
        <h4>찾으신 아이디는 : <%=dto.getId() %>입니다</h4><br/>
        <input type="submit" value="로그인하기"/>
    </form>

<%
    }
%>
