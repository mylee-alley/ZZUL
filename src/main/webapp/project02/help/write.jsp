<%@page import="web.bean.dto.HelpBoardDTO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 15px;
        }
    </style>	
</head>
<body>
<%    
    // 답글쓰기    
    int num = 0, ref = 1, re_step = 0, re_level = 0; 
    if (request.getParameter("num") != null) {
        num = Integer.parseInt(request.getParameter("num"));
        ref = Integer.parseInt(request.getParameter("ref"));
        re_step = Integer.parseInt(request.getParameter("re_step"));
        re_level = Integer.parseInt(request.getParameter("re_level"));
    }
%>
<div class="container">
    <h2 class="text-center">글쓰기</h2>
    <form method="post" action="writePro.jsp">
        <input type="hidden" name="num" value="<%=num%>"> 
        <input type="hidden" name="ref" value="<%=ref%>"> 
        <input type="hidden" name="re_step" value="<%=re_step%>"> 
        <input type="hidden" name="re_level" value="<%=re_level%>">
        <div class="form-group">
        
            <label for="writer">작성자</label>
            <% String sid = (String)session.getAttribute("sid"); %>
            <input type="text" class="form-control" id="writer" name="writer" value="<%=sid %>" readonly>
        </div>
        <div class="form-group">
            <label for="subject">제 목</label>
            <% if (request.getParameter("num") == null) { %> 
                <input type="text" class="form-control" id="subject" name="subject" maxlength="50">
            <% } else { %>
                <input type="text" class="form-control" id="subject" name="subject" value="[답변]" maxlength="50">
            <% } %>
        </div>
        <div class="form-group">
            <label for="content">내 용</label>
            <textarea class="form-control" id="content" name="content" rows="13"></textarea>
        </div>
        <div class="form-group text-center">
            <input type="submit" class="btn btn-primary" value="글쓰기">
            <input type="reset" class="btn btn-secondary" value="다시작성">
            <input type="button" class="btn btn-info" value="목록보기" onclick="window.location='list.jsp'">
        </div>
    </form>
    <div class="text-right">
        <a href="list.jsp" class="btn btn-link">글목록</a>
    </div>
</div>
</body>
</html>
