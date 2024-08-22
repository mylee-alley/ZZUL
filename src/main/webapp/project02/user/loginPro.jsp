<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.MemberDTO" %>
<%@ page import="web.bean.dao.MemberDAO" %>
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO" />
<jsp:setProperty name="dto" property="*" />
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO" />

<%
	Cookie [] cookies = request.getCookies();
	String cid = null, cpw = null, cauto = null;
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("cid")){
				cid = c.getValue();
			}
			if(c.getName().equals("cpw")){
				cpw = c.getValue();
			}
			if(c.getName().equals("cauto")){
				cauto = c.getValue();
			}
		}
	}
	
	if(cid != null && cpw != null && cauto != null){
		dto.setId(cid);
		dto.setPw(cpw);
		dto.setAuto(cauto);
	}
	
	int result = dao.memberlogin(dto);
	if(result == 1){
	  session.setAttribute("sid", dto.getId());
	  if(dto.getAuto() != null){
		  Cookie cooid = new Cookie("cid", dto.getId());
		  Cookie coopw = new Cookie ("cpw", dto.getPw());
		  Cookie cooauto = new Cookie ("cauto", dto.getAuto());
		  cooid.setMaxAge(60*60*24);
		  coopw.setMaxAge(60*60*24);
		  cooauto.setMaxAge(60*60*24);
		  response.addCookie(cooid);
		  response.addCookie(coopw);
		  response.addCookie(cooauto);
	}
	  response.sendRedirect("/project/project02/home.jsp");
	}else if(result==-1){
%> <script>
      alert("로그인이 제한되었습니다. 문의를 남겨주시기 바랍니다.");
      history.go(-1);
   </script>
<% }else{ 
%> <script>
      alert("id/pw를 확인하세요!");
      history.go(-1);
   </script>
<% } %>