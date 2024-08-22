<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />
<h1>ID 중복확인 </h1>
<%
 String id = request.getParameter("id");
 int idChecked = 0;
 int result = dao.idCheck(id);
 if(result == 0){
    idChecked = 1 ; %>
    <h3> [<%=id%>] 사용 가능합니다.</h3>
    <input type="hidden" name="idChecked"/>    
<% } else{
    idChecked = 0 ;%>
   <h3> [<%=id%>] 사용 불가합니다.</h3>
   <form action="idCheck.jsp">
   id: <input type="text" name="id"/>
   <input type="submit" value="중복확인"/>
   <input type="hidden" name="idChecked"/><br/>
   </form>
<%}%>
<br/>
<button onclick="selfClose()">닫기</button>
<script>
   function selfClose() {
      opener.document.getElementById("id").value="<%=id%>";
      console.log("idCheck.jsp selfClose() :::: " + <%=idChecked%>);
      opener.document.getElementById("idChecked").value="<%=idChecked%>";
      self.close();
   }
   opener.document.getElementById("idChecked").value="<%=idChecked%>";
</script>   