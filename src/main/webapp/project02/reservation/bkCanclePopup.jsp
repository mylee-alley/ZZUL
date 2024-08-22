<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="web.bean.dto.ReservationDTO"%>
<%@ page import="web.bean.dao.ReservationDAO"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dao" class="web.bean.dao.ReservationDAO" />
<jsp:useBean id="dto" class="web.bean.dto.ReservationDTO" />

<%
   String sid = (String) session.getAttribute("sid");
   List<ReservationDTO> list = dao.getArticle2(sid);
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

   String vdate = request.getParameter("visit_date");
   String vtime = request.getParameter("visit_time");
    String name = request.getParameter("rsvt_name");
    String[] menu = request.getParameterValues("menu[]"); // 배열로 변환
    String hcount = request.getParameter("rsvt_head_count");
    String rid = request.getParameter("getRsvt_id");
    String vdateresult = vdate.substring(0,11);
%>

<h3>예약정보를 다시 확인 바랍니다.</h3>
<hr>
<div >
<p><b>==예약정보==</b></p>

<p><li><b>예약 날짜/시간:</b> <%= vdateresult %> / <%= vtime %></li></p>
<p><li><b>예약자 이름:</b> <%= name %></li></p>
<p><li><b>예약 메뉴:</b> 
<%   for(String menus : menu){
%>
<%=menus%></li>
<%} %></p>
<p><li><b>인 원:</b> <%= hcount %></li></p>
<p><li><b>예약번호:</b> <%= rid %></li></p>
<hr>
<form action="bkCanclePro.jsp" method="post">
    <p><li><b>취소사유를 선택해주세요</b></li></p>
    <input type="radio" name="reason" value="일정변경"/>일정변경<br/>
    <input type="radio" name="reason" value="단순변심"/>단순변심<br/>
    <input type="radio" name="reason" value="기타"/>기타 (직접입력)
    <input type="text" name="reasonText"><br/>
    <br>
    <h5>예약을 취소하시겠습니까?</h5>
    <input type="hidden" name="rid" value="<%= rid %>">
    <input type="submit" value="예">
    <input type="button" onclick="history.back()" value="아니오">   
</form>
</div>