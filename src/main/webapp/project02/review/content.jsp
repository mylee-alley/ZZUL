<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="web.bean.dao.ReviewDAO" %>
<%@ page import="web.bean.dto.ReviewFileDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dto.MenuDTO" %>
<%@ page import="web.bean.dao.MenuDAO" %>
<%@ page import="web.bean.dao.ReservationDAO" %>
<%@ page import="web.bean.dto.ReservationDTO" %>
<jsp:useBean id="dto" class="web.bean.dto.ReviewDTO" />
<jsp:include page="../header.jsp" flush="true"/>
<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   ReviewDAO dao = new ReviewDAO();
   dto = dao.getReview(num);
   
   List reviewImg = null;
   reviewImg = dao.getReviewImg(num);
   
   int ref = dto.getRef();
   int re_step = dto.getRe_step();
   int re_level = dto.getRe_level();
   
   MenuDAO menudao = new MenuDAO();
   MenuDTO menudto = new MenuDTO();
   
   String sid = (String)session.getAttribute("sid");
%>
<center><b>리뷰 내용 보기</b></center><br/>
<table width="600" border="1" cellspacing="0" cellpadding="0" align="center">
   <tr>
      <td align="center" width="150">글번호</td>
      <td align="center" width="150"><%=dto.getNum() %></td>
      <td align="center" width="150">작성자</td>
      <td align="center" width="150">
      <%if(!dto.getWriter().equals("null")){ %>
         <%=dto.getWriter() %>
      <%}else{ %>
         비회원
      <%} %></td>
   </tr>
   <% if(!dto.getWriter().equals("admin")){ %>
      <tr>
         <td align="center" width="150">예약한 메뉴</td>
         <td align="center" width="150" colspan="3">
            <%    ReservationDAO rsvtdao = new ReservationDAO();
               List<String> menu = rsvtdao.getMenuList(dto.getRsvt_id());
               for(String menus : menu) {%>
                  <%=menus %><br/>
<%               } %>
         </td>
      </tr>
      <tr>
         <td align="center" width="150">별점</td>
         <td align="center" width="150" colspan="3">
            <%if(dto.getStar()==1){ %>★
            <%}else if(dto.getStar()==2){ %>★★
            <%}else if(dto.getStar()==3){ %>★★★
            <%}else if(dto.getStar()==4){ %>★★★★
            <%}else{ %>★★★★★<% } %>
         </td>
      </tr>
   <%   } %>
   <tr>
      <td align="center" width="150">제목</td>
      <td align="center" width="450" colspan="3"><%=dto.getSubject() %></td>
   </tr>
   <tr>
      <td align="center" width="150">리뷰 내용</td>
      <td align="center" width="450" colspan="3">
      <%
         for(int i = 0; i < reviewImg.size(); i++){
            ReviewFileDTO fileDTO = (ReviewFileDTO)reviewImg.get(i); %>
            <img src="/project/resources/image/review_img/<%=fileDTO.getFilename()%>" width="200"><br><br>
      <%   } %>
         <%=dto.getContent() %>
      </td>
   </tr>
   <tr>
      <td colspan="4" align="right">
         <%if(sid != null){ 
            if(sid.equals(dto.getWriter()) || sid.equals("admin")) {%>
         <input type="button" value="리뷰 삭제" onclick="confirmDelete(<%=num%>, <%=pageNum%>)">
         <%   } 
         } %>
         <%if(sid != null){ 
            if(sid.equals("admin")) {%>
         <input type="button" value="답글 작성" onclick="window.location='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
         <%   } 
         } %>
         <input type="button" value="리뷰 목록" onclick="window.location='list.jsp?pageNum=<%=pageNum%>'">
      </td>
   </tr>
</table>
<script>
   function confirmDelete(num, pageNum){
      var confirmed = confirm("정말 삭제하시겠습니까?");
      if(confirmed){
         window.location='deletePro.jsp?num='+num+'&pageNum='+pageNum
      }else{
         
      }
   }
</script>