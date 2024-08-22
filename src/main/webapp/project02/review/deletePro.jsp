<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="web.bean.dao.ReviewDAO" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	ReviewDAO dao = new ReviewDAO();
	List<String> fileNames = dao.deleteReview(num);
	if(fileNames != null){
		String path = request.getRealPath("resources/image/review_img");
		for(String fn : fileNames){
			File f = new File(path+"/"+fn);
			f.delete();
		}
	}
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">