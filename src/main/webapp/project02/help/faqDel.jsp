<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="web.bean.dao.FaqDAO" />

<%
int faqNum = Integer.parseInt(request.getParameter("faqNum"));
int result = dao.faqDel(faqNum);
if(result==1){
%>
<script>
alert("삭제되었습니다.")
window.location='faqList.jsp';
</script>
<%} else{%>
<script>
alert("삭제안됨")
history.go(-1);
</script>
<%}%>