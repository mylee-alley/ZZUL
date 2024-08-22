<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.MenuDAO" %>
<%  request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num")); 
	
	MenuDAO dao = new MenuDAO();
	int result = dao.menuDelete(num); 
    
	if(result == 1){ %>
		   <script>
		    alert("메뉴 삭제 되었습니다.");
		    window.location = 'menuList.jsp';
		   </script>
	<%     } else { %>
	   <script>
	    alert("삭제할 메뉴 정보를 다시 확인해주세요");
	    history.go(-1);
	   </script>
<%   } %>
