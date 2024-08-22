<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
   <jsp:useBean id="dto" class="web.bean.dto.MenuDTO" />
   <jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
         
<%
    int num = Integer.parseInt(request.getParameter("num")); // 파라미터 받은걸 int num 에 담겠다
   dto = dao.getMenuDetail(num);   // getMenuDetail 메소드 실행 

%>
   <h1>관리자 메뉴 수정</h1>
   <form action="updatePro.jsp" method="post">   
   <input type="hidden" name="num" value="<%=num %>" />
   메뉴 이름 : <input type="text" name="name" value="<%=dto.getName() %>"  /><br/>
   메뉴 설명 : <input type="text" name="detail" value="<%=dto.getDetail() %>" /><br/>
   가격 : <input type="text" name="price" value="<%=dto.getPrice() %>" /><br/>
   
   
  
      판매여부:  판매 가능<input type="radio" name="onoff" value="1"  
               <%if(dto.getOnoff() == 1){%> checked="checked" <%} %>/>
         판매 중지<input type="radio" name="onoff" value="0"
               <%if(dto.getOnoff() == 0){%> checked="checked" <%} %>/><br/>
         
         
         
   <input type="button" value="사진등록" onclick="window.open('imgChange.jsp?num=<%=num %>', '_blank', 'width=500, height=400')" /><br/><br/>
   <input type="submit" value="메뉴 수정" />
   </form>
   
   