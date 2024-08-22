<%@page import="web.bean.dto.MemberDTO"%>
<%@page import="web.bean.dao.MemberDAO"%>
<%@page import="web.bean.dao.RsvtHelpDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.bean.dto.RsvtHelpDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<title>게시판</title>

<%
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
   String pawd = request.getParameter("passwd");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   RsvtHelpDAO hdao = new RsvtHelpDAO();
   RsvtHelpDTO hdto = hdao.getHrlpSelect(num);
   MemberDAO mdao = new MemberDAO();
   String sid = (String)session.getAttribute("sid");
   
   MemberDTO mdto = mdao.member(sid);
   int ref=hdto.getRef();
   int re_step=hdto.getRe_step();
   int re_level=hdto.getRe_level();
%>
   <center>
      <b>글내용보기</b><br/>
      <%if(hdto.getPasswd().equals(mdto.getPw()) || hdto.getPasswd().equals(pawd) ||(sid!=null && sid.equals("admin"))){ %>
      <table>
         <tr>
         <td>글번호</td>
         <td><%=hdto.getNum() %></td>
         </tr>
         <tr>
            <td>작성자</td>
            <%if(sid != null){ %>
            <td><%=hdto.getWriter() %></td>
            <%} else{%>
            <td>비회원</td>
            <%} %>
            <td>작성일</td>
            <td><%=sdf.format(hdto.getReg_date()) %></td>
         </tr>
         <tr>
            <td>이메일</td>
            <td><%=hdto.getEmail() %></td>
         </tr>
         <tr>
            <td>글제목</td>
            <td><%=hdto.getSubject() %></td>
         </tr>
         <tr>
            <td>글내용</td>
            <td><pre><%=hdto.getContent() %></pre></td>
         </tr>
         
            <%if(sid!=null && sid.equals("admin")){ %>
            <tr>               
               <td><form action="rsvtHelpWriteForm.jsp?num=<%=hdto.getNum() %>&ref=<%=hdto.getRef() %>&re_step=<%=hdto.getRe_step() %>&re_level=<%=re_level %>" method="post">
                  <input type="hidden" name="subject" value="<%=hdto.getSubject() %>">
                  <input type="hidden" name="content" value="<%=hdto.getContent() %>">
                  <input type="hidden" name="passwd" value="<%=hdto.getPasswd() %>">
                  <input type="submit" value="답변하기">
                  </form>
               </td>
            </tr>
            <%} %>
      </table>
      <%}else{ %>
      <script>
         alert("비밀번호가 맞지 않습니다");
           history.go(-1);
        </script>
      <%} %>
   </center>