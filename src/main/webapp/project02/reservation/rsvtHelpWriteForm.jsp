<%@page import="web.bean.dto.MemberDTO"%>
<%@page import="web.bean.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>게시판</title>

<% request.setCharacterEncoding("UTF-8");%>
<% 
   MemberDAO mdao = new MemberDAO();
   int num=0,ref=1 , re_step=0, re_level=0;
   String subject = null , content=null , rsvt_id=null ,passwd=null;
   String sid=(String)session.getAttribute("sid");
   MemberDTO mdto = mdao.member(sid);
   if(request.getParameter("num")!=null){
      num=Integer.parseInt(request.getParameter("num"));
      ref=Integer.parseInt(request.getParameter("ref"));
      re_step=Integer.parseInt(request.getParameter("re_step"));
      re_level=Integer.parseInt(request.getParameter("re_level"));
      subject = request.getParameter("subject");
      content = request.getParameter("content");
      passwd = request.getParameter("passwd");
   }
   if(request.getParameter("rsvt_id")!=null){
      rsvt_id = request.getParameter("rsvt_id");
   }
%>
<center><d>글쓰기</d>
<br>
   <form method="post" name="writeform" action="rsvtHelpWritePro.jsp">
      <input type="hidden" name="num" value="<%=num %>">
      <input type="hidden" name="ref" value="<%=ref %>">
      <input type="hidden" name="re_step" value="<%=re_step %>">
      <input type="hidden" name="re_level" value="<%=re_level %>">
      
      <table>
         <tr>
            <td><a href="rsvtHelpList.jsp">글목록</a></td>
         </tr>
         <tr>
            <th>ID</th>
            <%if(sid != null){ %>
            <td><%=sid %>
               <input type="hidden" name="writer" value="<%=sid%>">               
            </td><%}else{ %>
            <td>비회원
               <input type="hidden" name="writer" value="비회원">               
            </td>
            <%} %>
         </tr>
         <%if(sid == null){ %>
            <tr>
               <th>비밀번호 </th>
               <td>
                  <input type="password" name="passwd" required>
               </td>
            </tr>
         <%}else if(sid != null && sid.equals("admin")){ %>
            <input type="hidden" name ="passwd" value="<%=passwd%>">
         <%}else{ %>
            <input type="hidden" name ="passwd" value="<%=mdto.getPw()%>">
         <%} %>
         <tr>
            <th>제목</th>
            <td>
               <%if(request.getParameter("num") == null){ %>
                  <input type="text" size="40" maxlength="50" name="subject" required>
               <%}else{ %>
                  <input type="text" size="40" maxlength="50" name="subject" value="[답변]<%=subject%>" required>
               <%} %>
            </td>
         </tr>
         <tr>
            <th>Email</th>
            <%if(sid!=null){ %>
               <td>
                  <%=mdto.getEmail() %>
                  <input type="hidden" name="email" value="<%=mdto.getEmail() %>">
               </td>
            <%}else{ %>
               <td>
                  <input type="text" size="40" maxlength="30" name="email" Placeholder="이메일작성을 꼭해주세요 답변은 이메일로갑니다." required>
               </td>
            <%} %>
         </tr>
         <tr>
            <th>내용</th>
            <td>
               <%if(rsvt_id != null){ %>
                  <textarea name="content" rows="13" cols="40" required><%=rsvt_id %></textarea>
               <%}else if(request.getParameter("num") == null) { %>
                  <textarea name="content" rows="13" cols="40" required></textarea>
               <%}else{%>
                  <textarea name="content" rows="13" cols="40" required>주문번호 : <%=content %></textarea>
               <%} %>
            </td>
         </tr>
         <tr>
            <td>
               <input type="submit" value="글쓰기">
                     
            </td>
            <td>
            <%if(sid!=null &&sid.equals("admin")){ %>
            <button value="목록보기" OnClick="window.location='rsvtHelpList.jsp'">목록으로</button>
            <% }%>
            </td>
         </tr>
      </table>
      </form>
</center>