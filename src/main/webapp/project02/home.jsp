<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" flush="true"/>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dto.MenuDTO" %>
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<%
   String sid = (String)session.getAttribute("sid");
%>

<style>
   table { margin-left:auto; margin-right:auto; }
   a { text-decoration-line: none; color: black;}
</style>
<% if(sid!=null && sid.equals("admin")) {%>
<table>
   <tr height="30">
      <td width="150" > 회사소개 </td>
      <td width="100" > 메뉴관리 </td>
      <td width="150" > 예약관리 </td>
      <td width="" > 매출통계 </td>
      <td width="" > 고객센터 </td>
      <td width="" > 리뷰  </td>
      <td width="" > 회원관리 </td>
   </tr>
   <tr><td width="150" height="30" >  </td></tr>
   <tr height="30">
      <td width="150" > <a href="" style="color: pink">회사소개</a> </td>
      <td width="100" > <a href="menu/menuList.jsp">메뉴관리</a> </td>
      <td width="150" > <a href="reservation/mgRsvtList.jsp?divis=today" >금일예약내역</a> </td>
      <td width="150" > <a href="sales/sales.jsp" style="color: red">매출액</a> </td>
      <td width="150" > <a href="help/faqList.jsp">FAQ</a> </td>
      <td width="150" > <a href="review/list.jsp">전체리뷰관리</a> </td>
      <td width="150" > <a href="user/gradeManagingMain.jsp">회원목록</a> </td>
   </tr>
   <tr height="30">
      <td width="150" > <a href="" style="color: pink">오시는길</a> </td>
      <td width="150" > </td>
      <td width="100" > <a href="reservation/mgRsvtList.jsp?divis=all" >전체예약내역</a> </td>
      <td width="150" > <a href="" style="color: pink">예약자수</a> </td>
      <td width="150" > <a href="help/list.jsp">1대1문의</a> </td>
      <td width="150" > </td>
      <td width="150" > <a href="user/newMemberList.jsp">신규회원</a> </td>
   </tr>
   <tr height="30">
      <td width="150" > <a href="company/notiList.jsp">공지사항</a> </td>
      <td width="100" > </td>
      <td width="150" > <a href="reservation/mgRsvtList.jsp?divis=cancel">예약취소내역</a> </td>
      <td width="150" > <a href="" style="color: pink">상품판매순위</a> </td>
      <td width="150" > <a href="" style="color: pink">제휴문의</a></td>
      <td width="150" > </td>
      <td width="150" > <a href="" style="color: pink">단골손님</a> </td>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="100" > </td>
      <td width="150" > <a href="reservation/mgRsvtSetting.jsp">예약세부설정</a> </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > <a href="" style="color: pink">휴면회원</a> </td>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="100" > </td>
      <td width="150" > <a href="reservation/rsvtHelpList.jsp">예약문의목록</a></td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > <a href="" style="color: pink">블랙리스트</a> </td>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="100" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > <a href="user/gradeManagingMain.jsp">회원등급관리</a> </td>
   </tr>
</table><br><br>
<% } else {%>
<table>
   <tr height="30">
      <td width="150" > 회사소개 </td>
      <td width="150" > 메뉴소개 </td>
      <td width="100" > 예약하기 </td>
      <td width="150" > 고객센터 </td>
      <td width="150" > 리뷰 </td>
      <%if(sid!=null){ %>
      <td width="170" > 마이페이지 </td>
      <%} %>
   </tr>
   <tr><td width="150" height="30" >  </td></tr>
   <tr height="30">
      <td width="150" > <a href="" style="color: pink">회사소개</a> </td>
      <td width="150" > <a href="menu/menuList.jsp">메뉴소개</a> </td>
      <td width="150" > <a href="reservation/reserveForm.jsp">예약하기</a> </td>
      <td width="150" > <a href="help/faqList.jsp">FAQ</a> </td>
      <td width="150" > <a href="review/list.jsp">리뷰보기</a> </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="reservation/bkInfo.jsp">예약내역</a> </td>
      <% } %>
   </tr>
   <tr height="30">
      <td width="150" > <a href="" style="color: pink">오시는길</a> </td>
      <td width="150" > </td>
      <td width="150" > <a href="reservation/rsvtHelpWriteForm.jsp">예약문의</a> </td>
      <td width="150" > <a href="help/list.jsp">1대1문의</a> </td>
      <td width="150" > </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="" style="color: pink">나의문의</a> </td>
      <% } %>
   </tr>
   <tr height="30">
      <td width="150" > <a href="company/notiList.jsp" >공지사항</a> </td>
      <td width="150" > </td>
      <td width="150" > <a href="reservation/reservationView.jsp">비회원예약조회</a> </td>
      <td width="150" > <a href="" style="color: pink">제휴문의</a> </td>
      <td width="150" > </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="review/myReview.jsp">나의리뷰</a> </td>
      <% } %>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="user/myPage.jsp" >개인정보확인 및 수정</a> </td>
      <% } %>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="user/pwChange.jsp">비밀번호 변경</a> </td>
      <% } %>
   </tr>
   <tr height="30">
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <td width="150" > </td>
      <%if(sid!=null){ %>
      <td width="170" > <a href="user/delete.jsp">회원탈퇴</a> </td>
      <% } %>
   </tr>
</table><br><br>
<% } %>
<div align="center">
<%   List menuList = dao.getMenu();
   for(int i=0; i < menuList.size(); i++){
      MenuDTO dto = (MenuDTO) menuList.get(i);
      int onoff = dto.getOnoff();
      if(onoff==1){
%>   <a href="menu/detail.jsp?num=<%=dto.getNum()%>"><img src="/project/resources/image/menu/<%=dto.getImg()%>" height="300" /></a>
<%      } 
   } %>
</div>