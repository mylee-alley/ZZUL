<%@page import="web.bean.dao.HelpBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
  <% request.setCharacterEncoding("UTF-8");%>
<%
	
	int ref = Integer.parseInt(request.getParameter("ref"));
    String pageNum = request.getParameter("pageNum");
 	System.out.print(ref);


  
  	HelpBoardDAO dbPro = new HelpBoardDAO();
   	int result= dbPro.helpDelete(ref);
    if(result >= 1){
 %>	  <script>
         alert("삭제 되었습니다");
          window.location="list.jsp";
 
       </script>
   <%}else%>{
   
   		 <script>
         alert("삭제에 실패했습니다.");
         history.go(-1);
 
       </script>

