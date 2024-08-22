<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>  
<%@ page import="web.bean.dto.NoticeDTO" %>  
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.NoticeDAO"/> 
<h1>상세내용</h1>
<%

   int notiNum = Integer.parseInt(request.getParameter("notiNum"));
   String pageNum = request.getParameter("pageNum");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd  HH:mm");
   
   List notiContent = null;
   notiContent = dao.sameNotiNumR(notiNum);//notiNum과 일치하는 레코드 가져오기
      
   for(int x=0 ; x < notiContent.size() ; x++){
   NoticeDTO dto = new NoticeDTO();
   dto = (NoticeDTO)notiContent.get(x);
   
   //로그인 후 글쓰기 이용 가능
    String sid = (String)session.getAttribute("sid");
    if(sid != null && sid.equals("admin")){ %>    
   <table width="600"><tr>
   <td align="right" >
   <form action="notiDel.jsp" method="post" enctype="multipart/form-data">
   <input type="hidden" name="notiNum" id="notiNum" value="<%=notiNum %>"/>   
   <input type="hidden" name="img" id="img" value="<%=dto.getImg()%>"/>
   
   <input type="button" value="수정" 
   onclick="window.location='notiChange.jsp?notiNum=<%=notiNum%>&title=<%=dto.getTitle()%>&content=<%=dto.getContent()%>'"/>
   
   <input type="submit" value="삭제" onclick="delCheck()" />
   </form>   
   </tr></table>
   <% } %>
   
   <table border="1" width="600"><tr>
      <td align="center" width="80" >제목</td>
      <td align="center" width="520" ><%=dto.getTitle()%></td>      
   </tr></table>
   
   <table border="1" width="600">
   <td align="center" width="80">작성일</td>
   <td align="center" width="520"><%=sdf.format(dto.getReg_date())%></td>
   </table>   
   
   
   <table border="1" width="600">
   <td align="center" width="80">내용</td>
   <td align="center" width="520"><%=dto.getContent()%><br><br>
   <%if(dto.getImg()==null){}else{%>
   <img src="/project/resources/image/notice/<%=dto.getImg()%>" width="450"><%}%></td>   
   </table>         
<%   }//for문 종료 %>
      
   <table  width="600">
   <td align="right" >
   <button onclick="location.href='notiList.jsp'">목록</button></td></table>