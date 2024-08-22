<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dao.ReviewDAO" %>
<%@ page import="web.bean.dto.ReviewDTO" %>
<%@ page import="web.bean.dto.MenuDTO" %>
<%@ page import="web.bean.dao.MenuDAO" %>
<%@ page import="web.bean.dao.ReservationDAO" %>
<%@ page import="web.bean.dto.ReservationDTO" %>
<jsp:include page="../header.jsp" flush="true"/>
<%
   int pageSize = 10;
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   String pageNum = request.getParameter("pageNum");
   
   if(pageNum == null){
      pageNum = "1";
   }
   
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage-1)*pageSize+1;
   int endRow = currentPage*pageSize;
   
   int count = 0;
   
   List reviewList = null;
   ReviewDAO dao = new ReviewDAO();
   
   count = dao.getReviewCount();
   
   if(count > 0){
      reviewList = dao.getReviewList(startRow, endRow);
   }   
   
   MenuDAO menudao = new MenuDAO();
   MenuDTO menudto = new MenuDTO();
   
   String sid = (String)session.getAttribute("sid");
%>
<center><b>리뷰 목록(전체 리뷰:<%=count %>)</b></center>
<% if(count==0){ %>
   <table>
      <tr>
         <td>
            작성된 리뷰가 없습니다.
         </td>
      </tr>
   </table>
<% }else { %>
   <table border="1" width="" align="center" cellpadding="0" cellspacing="0">
      <tr height="30">
         <td align="center" width="50">글번호</td>
         <td align="center" width="350">제목</td>
         <td align="center" width="50">별점</td>
         <td align="center" width="450">예약한 메뉴</td>
         <td align="center" width="100">작성자</td>
         <td align="center" width="150">작성일</td>
      </tr>
<%

   for(int i = 0; i <reviewList.size(); i++){
      ReviewDTO dto = (ReviewDTO)reviewList.get(i);
      
%>      <tr height="30">
         <td align="center" width="50"><%=dto.getNum() %></td>
         <td width="300">
<%
      int wid=0;
      if(dto.getRe_level()>0){
         wid = 20*(dto.getRe_level());
%>
         <img src="" width="<%=wid%>" height="16">
<%      } else{ %>
         <img src="" width="<%=wid%>" height="16">
<%      } %>
         <a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
            <%=dto.getSubject() %>
         </a></td>
            
<%
         ReservationDAO rsvtdao = new ReservationDAO();
         List<String> menu = rsvtdao.getMenuList(dto.getRsvt_id());
         if(dto.getWriter()==null || !dto.getWriter().equals("admin")){
%>            <td align="center" width="50"><%=dto.getStar() %></td>
            <td>
               <% for(String menus : menu) {%>
                  <%=menus %><br/>
<%               } %>
            </td>
<%         }else { %>
            <td align="center" width="50"></td>
            <td align="center" width="400"></td>
<%         }
%>            
            
         <td align="center" width="100">
<%         if(!dto.getWriter().equals("null")){
%>            <%=dto.getWriter() %>   
<%         }else{
%>            비회원
<%         } %></td>
         <td align="center" width="100"><%=sdf.format(dto.getReg_date()) %></td>
      </tr>
<% } %>         
   </table>
<% } %>
<center>
<%
   if(count > 0){
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int startPage = (int)(currentPage/10)*10+1;
      int pageBlock = 10;
      int endPage = startPage + pageBlock -1;
      if(endPage > pageCount) endPage = pageCount;
      if(startPage > 10) { %>
         <a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%      }
      for(int i=startPage; i <= endPage; i++){%>
         <a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%      }
      if(endPage < pageCount){ %>
         <a href="list.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%      }
   }
%>
</center>