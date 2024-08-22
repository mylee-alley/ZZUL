<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dao.MenuDAO" %>
<%@ page import="web.bean.dto.MenuDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../header.jsp" flush="true"/>
<script>
   n=1;
   function fileAdd(){
      upload = document.getElementById("upload");
      upload.innerHTML = upload.innerHTML + "<input type='file' name='img"+(n++)+"'><br>"
   }
</script>
<%
   int num=0, ref=1, re_step=0, re_level=0;

   if(request.getParameter("num")!=null){
      num = Integer.parseInt(request.getParameter("num"));
      ref = Integer.parseInt(request.getParameter("ref"));
      re_step = Integer.parseInt(request.getParameter("re_step"));
      re_level = Integer.parseInt(request.getParameter("re_level"));
   }
   
   List menu = null;
   MenuDAO menudao = new MenuDAO();
   menu = menudao.getMenu();
   String [] menus = request.getParameterValues("menu[]");
   String rsvt_id = request.getParameter("rsvt_id");

%>
<center><b>글쓰기</b></center>
<form action="writePro.jsp" method="post" name="writeform" encType="multipart/form-data">
   <input type="hidden" name="num" value="<%=num%>">
   <input type="hidden" name="ref" value="<%=ref%>">
   <input type="hidden" name="re_step" value="<%=re_step %>">
   <input type="hidden" name="re_level" value="<%=re_level %>">
   <table width="600" border="1" cellspacing="0" cellpadding="0" align="center">
      <tr>
         <td align="right" colspan="2">
            <a href="list.jsp">글목록</a>
         </td>
      </tr>
      <tr>
         <td width="150" align="center">I D</td>
         <td width="450">
         <% String sid=(String)session.getAttribute("sid"); 
         if(sid!=null){%>
            <%=sid %>
         <%}else{ %>
            비회원
         <% } %>
            <input type="hidden" name="writer" value="<%=sid%>">
         </td>
      </tr>
      <tr>
         <td width="150" align="center">제 목</td>
         <td width="450">
            <% if(request.getParameter("num")==null){%>
               <input type="text" size ="60" maxlength="50" name="subject">
            <% }else{ %>
               <input type="text" size="60" maxlength="50" name="subject" value="[답변]">
            <% } %>
         </td>
      </tr>
      <% if(sid==null || !sid.equals("admin")) {%>
      <tr>
         <td width="150" align="center">예약한 메뉴</td>
         <td width="450">
            <%for(String menues : menus) { %>
                  <%=menues %><br/>
            <input type="hidden" name="rsvt_id" value="<%=rsvt_id%>">
            <% } %>
         </td>
      </tr>
      <tr>
         <td width="150" align="center">별 점</td>
         <td width="450">
            1<input type="range" name="star" min="1" max="5" step="1">5
         </td>
      </tr>
      <tr>
         <td width="150" align="center">사진 업로드</td>
         <td width="450" id="upload">
            <input type="button" value="사진 추가" onclick="fileAdd();"><br>
            <input type="file" name="img"><br>
         </td>
      </tr>
      <%} %>
      <tr>
         <td width="150" align="center">내 용</td>
         <td width="450">
            <textarea name="content" rows="20" cols="60"></textarea>
         </td>
      </tr>
      <tr>
         <td colspan="2" align="center">
            <input type="submit" value="리뷰 작성">
         </td>
      </tr>
   </table>
</form>