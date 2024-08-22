<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="web.bean.dto.HelpBoardDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="web.bean.dao.HelpBoardDAO"%>
<%@page import="java.sql.Time"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="article" class="web.bean.dto.HelpBoardDTO">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()));
	

	HelpBoardDAO dbPro = new HelpBoardDAO();
 	dbPro.insertArticle(article);

    response.sendRedirect("list.jsp");
%>