<%@page import="web.bean.dao.RsvtHelpDAO"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="web.bean.dto.RsvtHelpDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<%
int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   String pageNum = request.getParameter("pageNum");
   if(pageNum == null){
      pageNum = "1";
   }

   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1 ) * pageSize + 1;
   int endRow = currentPage * pageSize;
   int count = 0;
   List helpList = null;
   RsvtHelpDAO hdao = new RsvtHelpDAO();
   count = hdao.getHelpCount();
   if (count > 0){
      helpList = hdao.getHelps(startRow, endRow);      
   }
%>
<title>고객센터게시판</title>
<center>
<%
String sid = (String)session.getAttribute("sid");
%>
</center>

<%
      if (count == 0){
%>
      <table>
         <tr>
            <td>게시판에저장된글이 없습니다.</td>
         </tr>
      </table>
   
<%
   }else {
   %>
<center>
<table class="table table-hover">
   <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
   </tr>

   <%
   for(int i = 0; i<helpList.size();i++){
         RsvtHelpDTO help = (RsvtHelpDTO)helpList.get(i);
   %>
      <tr>
         <td><%=help.getNum() %></td>
         <% if (sid != null && (sid.equals(help.getWriter()) || sid.equals("admin"))) { %>   
            <td>
<%                int wid=0;
               if(help.getRe_level() > 0){
                  wid=5*(help.getRe_level());
               }
%>         
         <a href="rsvtHelpContent.jsp?num=<%=help.getNum()%>&pageNum=<%=currentPage%>">
         <%=help.getSubject() %>
         </a>
         </td>
         <%}else{ %>
            <td>
               <a href="rsvtHelpSecret.jsp?num=<%=help.getNum()%>&pageNum=<%=currentPage%>"><%=help.getSubject() %></a>
            </td>
         <%} %>
         <td><%=help.getWriter() %></td>
         <td><%=sdf.format(help.getReg_date()) %></td>
         <% if(sid !=null && sid.equals("admin")){%>
         <td><button onclick="window.location='rsvtHelpDelete.jsp?num=<%=help.getNum()%>&del=1'">삭제</button></td>
         <%} %>
      </tr>
   <%}
   }%>
   </table>
<% if(count > 0){
   int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
   int startPage = (int)(currentPage/10)*10+1;
   int pageBlock=10;
   int endPage = startPage + pageBlock-1;
   if (endPage > pageCount) endPage = pageCount;
   if (startPage > 10){ %>
   <a href="rsvtHelpList.jsp?pageNum=<%=startPage -10 %>">[이전]</a>
<%   }
   for(int i = startPage; i<=endPage; i++){%>
      <a href="rsvtHelpList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
   <%
   }
   if (endPage < pageCount){ %>
      <a href="rsvtHelpList.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%   }
}   %>
<button onclick="window.location='rsvtHelpWriteForm.jsp'">글쓰기</button>
</center>


