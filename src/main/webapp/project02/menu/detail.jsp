<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true" />
<jsp:useBean id="dto" class="web.bean.dto.MenuDTO" />
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<%
   int num = Integer.parseInt(request.getParameter("num"));
   dto = dao.getMenuDetail(num);
%>
<h1>메뉴 상세페이지</h1>


<img src="/project/resources/image/menu/<%=dto.getImg()%>" width="400"/><br/>
메뉴 이름 : <%=dto.getName() %><br/>
상세 설명 : <%=dto.getDetail() %><br/>
가격 : <%=dto.getPrice() %>원<br/>

<%//관리자만 메뉴 수정/삭제 가능
  //※삭제※ 관리자 페이지에는 없어지지만, DB에는 남아있게 수정해야함
   String sid = (String)session.getAttribute("sid");
   if(sid!=null && sid.equals("admin")){%>
   <form action="deletePro.jsp" method="post">
   <input type="hidden" name="num" id="num" value="<%=num %>"/>   
   <input type="button" value="수정" onclick="window.location='update.jsp?num=<%=num %>'" />
   <input type="submit" value="삭제" onclick="delCheck()" />
   </form>
<%} %><br><br>
   <input type="button" value="예약하기" onclick="window.location.href='/project/project02/reservation/reserveForm.jsp'">

<script>
  function delCheck(){
     if(confirm("정말 삭제하시겠습니까?")==true){
        num= document.getElementById("num").value;
           //현재 문서의.찾아라 태그의 아이디가("")인것의.값을        
        document.removefrm.submit();
        open("deletePro.jsp?id="+num);
     } else{
        return false;
     }
  }
</script>