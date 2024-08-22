<%@page import="web.bean.dao.RsvtHelpDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="hdto" class="web.bean.dto.RsvtHelpDTO"/>

<%
String path = request.getRealPath("resources/image/rsvtHlpe");
	String enc = "UTF-8";
	int max = 1024*1024*10;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	hdto.setNum(Integer.parseInt(mr.getParameter("num")));
	hdto.setRef(Integer.parseInt(mr.getParameter("ref")));
	hdto.setRe_step(Integer.parseInt(mr.getParameter("re_step")));
	hdto.setRe_level(Integer.parseInt(mr.getParameter("re_level")));
	hdto.setWriter(mr.getParameter("writer"));
	hdto.setSubject(mr.getParameter("subject"));
	hdto.setEmail(mr.getParameter("email"));
	hdto.setContent(mr.getParameter("content"));
	hdto.setPasswd(mr.getParameter("passwd"));
	
	hdto.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	RsvtHelpDAO hdao = new RsvtHelpDAO();
	hdao.inserthelp(hdto);
	
	response.sendRedirect("rsvtHelpList.jsp");
%>