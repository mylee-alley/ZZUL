<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "web.bean.dao.HelpBoardDAO" %>
<%@ page import = "web.bean.dto.HelpBoardDTO" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="article" scope="page" class="web.bean.dto.HelpBoardDTO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
 
    String pageNum = request.getParameter("pageNum");

	HelpBoardDAO dbPro = new HelpBoardDAO();
    dbPro.updateArticle(article);

    	
    response.sendRedirect("list.jsp");
%>
 