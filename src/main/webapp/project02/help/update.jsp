<%@page import="web.bean.dto.HelpBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.HelpBoardDAO" %>
<%@ page import="web.bean.dto.HelpBoardDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
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
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    HelpBoardDAO dbPro = new HelpBoardDAO();
    HelpBoardDTO article = dbPro.updateGetArticle(num);
%>
<div class="container">
    <h2 class="text-center">글수정</h2>
    <form method="post" name="writeform" action="updatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
        <div class="form-group">
            <label for="writer">이 름</label>
            <input type="text" class="form-control" id="writer" name="writer" value="<%=article.getWriter()%>" maxlength="10">
            <input type="hidden" name="num" value="<%=article.getNum()%>">
        </div>
        <div class="form-group">
            <label for="subject">제 목</label>
            <input type="text" class="form-control" id="subject" name="subject" value="<%=article.getSubject()%>" maxlength="50">
        </div>
        <div class="form-group">
            <label for="content">내 용</label>
            <textarea class="form-control" id="content" name="content" rows="13"><%=article.getContent()%></textarea>
        </div>
        <div class="form-group text-center">
            <input type="submit" class="btn btn-primary" value="글수정">
            <input type="reset" class="btn btn-secondary" value="다시작성">
            <input type="button" class="btn btn-info" value="목록보기" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
        </div>
    </form>
</div>

</body>
</html>
