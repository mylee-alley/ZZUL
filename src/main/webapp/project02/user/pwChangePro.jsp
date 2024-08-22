<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<jsp:useBean id="dao" class="web.bean.dao.MemberDAO"></jsp:useBean>   
<jsp:useBean id="dto" class="web.bean.dto.MemberDTO"/> 
<%
	String id = (String)session.getAttribute("sid");
   
	String pw =request.getParameter("pw");   // 기존 비밀번호   
	String newPw = request.getParameter("newPw"); // 새로운 비밀번호
	String oidPw = request.getParameter("oidPw");   // 새로운 비밀번호 확인
	dto = dao.member(id);   // 메서드 호출해서 모든 값을 dto 에 담았다
	String dbPw = dto.getPw();   // dbpw 에 저장되어있는 dto.getpw 값을 넣는다
   
    if (!dbPw.equals(pw)) {   // DB에 있는 패스워드가 입력한 패스워드랑 불일치한지 비교
%>
       <script>
          alert("기존 비밀번호와 불일치 합니다.");
           history.go(-1);
       </script>     
<%      
    }else if (dbPw.equals(newPw)) {   // DB에 있는 패스워드가 새로 입력한 패스워드랑 같은지비교
%>
        <script>
           alert("새로운 비밀번호가 기존 비밀번호와 동일합니다. 다른 비밀번호를 입력해주세요.");
            history.go(-1);
        </script>
<%
   }else if (!newPw.equals(oidPw)) { // 새로운 패스워드가 확인 패스워드랑 일치하지 않을시에
%>
    <script>
       alert("비밀번호가 일치하지 않습니다.");
        history.go(-1);
    </script>
<%
    } else {   // 모든 조건을 넘어갔으면
         dto.setPw(newPw);   //새로운 패스워드를 dto에 저장
         dao.pwUpdate(dto);   // DB에 업데이트   
 %>
<%
	session.invalidate();// 모든 세션 초기화
	Cookie [] cookies = request.getCookies();
	String cid = null, cpw = null, cauto = null;
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("cid")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cpw")){
            	c.setMaxAge(0);
            	response.addCookie(c);
        	}
			if(c.getName().equals("cauto")){
	            c.setMaxAge(0);
	            response.addCookie(c);
         	}
      	}
   	}
%>
        <script>
            alert("비밀번호가 변경되었습니다.");
            window.location="login.jsp";
        </script>
<% } %>   
    


        
        
        
        
        
        
        
        
        
        
        
        