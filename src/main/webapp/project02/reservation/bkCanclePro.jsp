<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="web.bean.dao.ReservationDAO"%>
<% request.setCharacterEncoding("UTF-8");%>

<%
   String rid = request.getParameter("rid");
   String rcr = request.getParameter("reason");
   String rcrt = request.getParameter("reasonText");
   
   ReservationDAO rdao = new ReservationDAO();
   int x = rdao.updateArticle(rid, rcr+ rcrt);

  if (x == 1) {
%>
    <script>
       alert("예약이 취소되었습니다.");
       window.close();    
       window.location="bkInfo.jsp";
    </script>
<%
    } else {
%>

    <script>
        alert("예약 취소에 실패했습니다.");
        history.go(-1);
    </script>
<%
    }
%>