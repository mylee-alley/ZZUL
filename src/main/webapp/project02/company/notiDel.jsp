<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.NoticeDAO"/> 
<jsp:useBean id="dto" class="web.bean.dto.NoticeDTO"/> 

 <%
  String path = request.getRealPath("resources/image/notice");
  MultipartRequest mr = new MultipartRequest(request,path);
  
  int notiNum = Integer.parseInt(mr.getParameter("notiNum"));
  dto.setNotiNum(notiNum);
  String fileName = mr.getParameter("img");
  
  int result = dao.notiDel(notiNum);
  
  if( result ==1 ){ 
	  File f = new File(path+"//"+fileName);
	  f.delete();
 %><script>
 	 alert("공지사항 삭제 되었습니다.")
 	 window.location = 'notiList.jsp';
   </script> 
 <%}else{%>
  <script>
 	  alert("공지사항 삭제에 실패하였습니다.")
 	  history.go(-1);
    </script> 
 <%}%>