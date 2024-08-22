<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dto" class="web.bean.dto.FaqDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%int faqNum=Integer.parseInt(request.getParameter("faqNum")); %>

<h1>FAQ UpDate</h1>

	<form action="faqUpdPro.jsp">
	<input type="hidden" name="faqNum" value="<%=faqNum%>"/>
	 <table border="1" width="600">
		<tr>
		  <td align="center" width="80" >제목</td>
	      <td align="center" width="520" >
	        <textarea rows="1" cols="50" name="question"><%=dto.getQuestion()%></textarea>
	      </td>
	    </tr>
	    <tr>
	 	  <td align="center" width="80" >내용</td> 
	 	  <td align="center" width="520" >
	 	  <textarea rows="10" cols="50" name="answer"><%=dto.getAnswer()%></textarea></td> 
	  </table>
	  <input type="submit" value="수정완료"/>
	  </form>