<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dto" class="web.bean.dto.NoticeDTO"/> 
<jsp:setProperty name="dto" property="*" />
<%int notiNum = Integer.parseInt(request.getParameter("notiNum"));%>
<h1>공지사항 수정</h1>

<form action="notiChgPro.jsp" method="post" enctype="multipart/form-data" >
 <input type="hidden" name="notiNum" value="<%=notiNum%>" />

 <table border="1" width="600"><tr>
	<td align="center" width="80" >제목</td>
	<td align="left" width="520" >
	<input type="text" name="title" value="<%=dto.getTitle() %>" /></td>		
 </tr></table>
 
 <table border="1" width="600"><tr>
	<td align="center" width="80" >사진변경</td>
	<td align="right" width="520" ><input type="file" name="img" value="<%=dto.getImg()%>"/></td>
  </tr></table>	
	
 <table border="1" width="600"><tr>
	<td align="center" width="80" >내용</td>
	<td align="left" width="520" >	
	<textarea id="content" name="content" rows="10" cols="50"><%=dto.getContent()%></textarea>		
 </tr></table>
 
 <input type="submit" value="수정완료"/> 
</form>