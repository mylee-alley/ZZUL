<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="web.bean.dto.MenuDTO" %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MenuDAO" />
<%//관리자만 메뉴등록 가능
   String sid = (String)session.getAttribute("sid");
   if(sid!=null && sid.equals("admin")){%>    
   <input type="button" value="메뉴등록" onclick="window.location='insert.jsp'"><br/><br/>
<%} %>
<%
   List menuList = null;
   menuList = dao.getMenu();
   
   for(int i = 0; i < menuList.size(); i++){
      MenuDTO dto = (MenuDTO)menuList.get(i);
      int onoff = dto.getOnoff();
      if(onoff == 1){ // 판매중	
%> 		<img src="/project/resources/image/menu/<%=dto.getImg()%>" width="200" /><br/>
	    메뉴 이름 : <a href="detail.jsp?num=<%=dto.getNum()%>"><%=dto.getName() %></a><br/>
	    가격 : <%=dto.getPrice() %><br/>
	    판매 여부 : 판매 중<br/>
	    <br/><br/><br/>
<%  } else if(onoff == 0){ // 판매중지 관리자만 보이게
		if(sid!=null && sid.equals("admin")){%>
			<img src="/project/resources/image/menu/<%=dto.getImg()%>" width="200" /><br/>
		    메뉴 이름 : <a href="detail.jsp?num=<%=dto.getNum()%>"><%=dto.getName() %></a><br/>
		    가격 : <%=dto.getPrice() %><br/>
		    판매 여부 : 일시 중지<br/>
		    <br/><br/><br/>
<%			}	
		} else{//onoff == 2 삭제 DB에는 남아있고 사용자,관리자는 안보이게		
	}
}
%>