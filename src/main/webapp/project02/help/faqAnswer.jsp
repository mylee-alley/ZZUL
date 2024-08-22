<%@page import="web.bean.dto.FaqDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dto.NoticeDTO" %>
<jsp:include page="../header.jsp" flush="true"/>  
<jsp:useBean id="dao" class="web.bean.dao.FaqDAO"/> 

<h1>답변</h1>
  
<%   
 int faqNum = Integer.parseInt(request.getParameter("faqNum"));
 List answer = dao.sameNreco(faqNum);
 
 for(int x=0; x<answer.size(); x++){
	 FaqDTO dto = new FaqDTO();
	 dto = (FaqDTO)answer.get(x); %>	 
	<table  width="600" >
	  <td align="right" >
		<form action="faqUpdate.jsp">
		  <input type="hidden" name="faqNum" id="faqNum" value="<%=faqNum%>"/>
		  <input type="hidden" name="question" id="question" value="<%=dto.getQuestion()%>"/>
		  <input type="hidden" name="answer" id="answer" value="<%=dto.getAnswer()%>"/>
<%String sid = (String)session.getAttribute("sid");
  if(sid != null && sid.equals("admin")){//관리자 로그인일때%>
		  <input type="button" value="삭제"onclick="window.location='faqDel.jsp?faqNum=<%=dto.getFaqNum()%>'"/>
		  <input type="submit" value="수정"/>		
<%} else{}%>
		</form>
	</td> 
	</table>

	 <table border="1" width="600">
		<tr>
		  <td align="center" width="80" >제목</td>
	      <td align="center" width="520" ><%=dto.getQuestion() %></td>
	    </tr>
	    <tr>
	 	  <td align="center" width="80" >내용</td> 
	 	  <td align="center" width="520" ><%=dto.getAnswer() %></td> 
	  </table>
	  
	<table  width="600"><td align="right" ><br/>
	<button onclick="location.href='faqList.jsp'">목록</button></td></table>
	 
 <%}
 %> 
