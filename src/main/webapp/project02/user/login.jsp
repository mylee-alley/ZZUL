<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<jsp:include page="../header.jsp" flush="true"/>
  <%
  	String sid = (String)session.getAttribute("sid");
  	if(sid == null){
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
  			response.sendRedirect("loginPro.jsp");
  		}
  	} else {
        response.sendRedirect("/project/project02/home.jsp");
     }

  %>
  
  <form action ="loginPro.jsp" method="post">
    아이디 : <input type ="text" name ="id"/> <br/>
    비밀번호 :   <input type ="password" name ="pw"/> <br/> 
    자동로그인 : <input type="checkbox" name="auto" value="1" />
       <input type ="submit" value ="login"/> <br/>
  </form>
  
 <a href="input.jsp">회원가입</a><br/>
 <a href="idJoin.jsp">아이디 찾기</a>
 <a href="pwJoin.jsp">비밀번호 찾기</a>
  