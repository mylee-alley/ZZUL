<%@page import="web.bean.dto.JspNameDTO"%>
<jsp:useBean id="jspNameDao" class="web.bean.dao.JspNameDAO" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.header_table { width: 100%; text-align: center;}
	.header_home { display : inline; font-size: 50px; color:black; text-decoration-line: none; }
	.header_login { text-decoration-line: none; color: black;}
	.header_b { font-size: 40px; }
	.footer_path { display : inline; position: fixed; bottom: 30px; }
	#login1 { position: fixed; top: 30px;  right: 120px; }
	#login2 { position: fixed; top: 30px;  right: 30px; }
	#logout { position: fixed; top: 30px;  right: 30px; }
</style>

<%
	String pathPiece ="";
    String path = request.getRequestURI();
    String sid = (String)session.getAttribute("sid");
    pathPiece = path.substring(path.lastIndexOf("/", 100));
    pathPiece = pathPiece.substring(1);
    
//     System.out.println("path ::: " + path);
//     System.out.println("pathPiece ::: " + pathPiece);
    JspNameDTO jspNameDto = new JspNameDTO();
    jspNameDto = jspNameDao.getJspName(path);
    
    String hompage = "home.jsp";
    String logout = "user/logout.jsp";
    String myPage = "user/myPage.jsp";
    String login = "user/login.jsp";
    String u = "../";
	if(pathPiece.equals("home.jsp")){
		
	} else {
		hompage = u + hompage;
		login = u + login;
		myPage = u + myPage;
		logout = u + logout;
	}
%>
<table class="header_table" >
	<tr>
		<td width="130" ><a class="header_home" href="<%=hompage %>" >home</a></td>
		<td width=""  colspan="3"><b class="header_b" ><%=jspNameDto.getUserShowExplain() %></b></td>
		<td width="130" >
			<%
				if(sid != null){
					%><a class="header_login" id="login1" href="<%=logout%>">로그아웃</a>
					<a class="header_login" id="login2" href="<%=myPage%>">마이페이지</a><%
				}else{
					%><a class="header_login" id="logout" href="<%=login%>">로그인</a><% 
				}
			%>
		</td>
	</tr>
</table>
<br />
<br />
<!-- <h1 class="footer_path" > 파일경로 : <%=path %> ♥</h1> -->