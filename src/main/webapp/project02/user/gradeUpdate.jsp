<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.MemberDAO" %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="memberDAO" class="web.bean.dao.MemberDAO" />
<jsp:useBean id="memberDTO" class="web.bean.dto.MemberDTO" />

<%
	String memberId = request.getParameter("userid");
	int newGrade = Integer.parseInt(request.getParameter("newGrade"));
	System.out.println("memberId:::: " +memberId+ "newGrade:::: "+newGrade);
    int result = memberDAO.updateMemberGrade(memberId, newGrade); // 등급 업데이트
    if(result == 1){
	    out.println("<p>등급이 성공적으로 변경되었습니다.</p>");
    }else {
	    out.println("<p>등급 변경에 실패했습니다.</p>");
    }

%>
<a href="radeManagingMain.jsp">목록으로 돌아가기</a>