<%@page import="web.bean.dto.HelpBoardDTO"%>
<%@page import="web.bean.dao.HelpBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .status-complete {
            color: green;
        }
        .status-pending {
            color: red;
        }
    </style>
</head>
<body>
<%    
    String sid = (String)session.getAttribute("sid");
    
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    HelpBoardDAO dbPro = new HelpBoardDAO();
    HelpBoardDTO article = dbPro.getArticle(num);
    int ref = article.getRef();
    int re_step = article.getRe_step();
    int re_level = article.getRe_level();
    int status = article.getStatus();
    
    // ref 값을 기반으로 답글 목록을 조회하되, 원본 글은 제외
    List<HelpBoardDTO> replyList = dbPro.getRepliesByRef(ref, num);
    
    // 답변 수 카운트
    int replyCount = replyList.size();
%>
<div class="container">
    <h1 class="text-center">글내용 보기</h1>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title text-center">글내용</h5>
            <table class="table table-bordered">
                <tr>
                    <th>글번호</th>
                    <td><%=article.getNum()%></td>
                    <th>답변상태</th>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td><%=article.getWriter()%></td>
                    <td>
                        <% if (replyCount > 0) { %>
                            <span class="status-complete">답변완료 (<%=replyCount%>)</span>
                        <% } else { %>
                            <span class="status-pending">대기중</span>
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td><%= sdf.format(article.getReg_date())%></td>
                    <td></td>
                </tr>
                <tr>
                    <th>글제목</th>
                    <td colspan="2"><%=article.getSubject()%></td>
                </tr>
                <tr>
                    <th>글내용</th>
                    <td colspan="2"><pre><%=article.getContent()%></pre></td>
                </tr>
                <tr>
                    <td colspan="3" class="text-right">
                        <% if(sid.equals(article.getWriter())) { %>      
                        <button class="btn btn-primary" onclick="window.location='update.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">글수정</button>
                        <% } %>
                        <% if(sid.equals(article.getWriter()) || sid.equals("admin")) { %>
                        <button class="btn btn-danger" onclick="window.location='deletePro.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>&ref=<%=ref%>'">글삭제</button>
                        <% } %>
                        <% if(sid.equals("admin")) { %>
                        <button class="btn btn-secondary" onclick="window.location='write.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">답글쓰기</button>
                        <% } %>
                        <button class="btn btn-info" onclick="window.location='list.jsp?pageNum=<%=pageNum%>'">글목록</button>
                    </td>
                </tr>
            </table>
            <h5 class="card-title text-center">답글 목록</h5>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(HelpBoardDTO reply : replyList) { %>
                    <tr>
                        <td><%=reply.getWriter()%></td>
                        <td><pre><%=reply.getContent()%></pre></td>
                        <td><%= sdf.format(reply.getReg_date())%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
