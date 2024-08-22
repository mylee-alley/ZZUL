<%@ page import="web.bean.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ page import="web.bean.dto.NoticeDTO" %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.NoticeDAO"/> 
<style>
	table { margin-left:auto; margin-right:auto; }
</style>

<center><h1>공지사항</h1>
<%	int count =dao.notiWrtCount(); %> 
(전체공지 : <%=count%>)</center>

<table width="600"><tr>
<td align="right" >
<%
	String sid = (String)session.getAttribute("sid");
	if(sid != null && sid.equals("admin")){//관리자로그인만 글쓰기 이용 가능
%>		<a href="notiWrite.jsp">글쓰기</a>
<%	} else if(sid != null){%>
<%	} else{%>
      	<a href="../user/login.jsp">로그인</a>
<%}%></td>         
</tr></table>

<table border="1" width="600"><tr>
<td align="center" width="470" >제목</td><td align="center" width="130">작성일</td>
</tr></table>

<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy. MM. dd");
	
	int pageSize=10;
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){pageNum = "1";}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;//페이지의 첫글
	int endRow = currentPage*pageSize;//페이지의 마지막글
	
	List notiList = dao.notilist(startRow, endRow);
	
	for(int x=0 ; x < notiList.size() ; x++){
		NoticeDTO dto = (NoticeDTO)notiList.get(x); %>
		<table border="1" width="600"><tr>
		<td align="center" width="470" >
		<a href="notiContent.jsp?notiNum=<%=dto.getNotiNum()%>"> <%=dto.getTitle()%></a></td>
		<td align="center" width="130"><%=sdf.format(dto.getReg_date())%></td>
		</tr></table>
<%	} %>

<center>	
<%		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//페이지수
		int startPage = (int)(currentPage/10)*10+1;//[1]페이지
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;//[?]마지막페이지
		if(endPage > pageCount) endPage = pageCount;
		if(startPage > 10) { %>
			<a href="notiList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%		}
		for(int i=startPage; i <= endPage; i++){%>
			<a href="notiList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if(endPage < pageCount){ %>
			<a href="notiList.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%		} %></center>

