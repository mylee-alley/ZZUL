<%@page import="web.bean.dao.HelpBoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="web.bean.dto.HelpBoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../header.jsp" flush="true"/>
<%
    String sid = (String)session.getAttribute("sid");

    int pageSize = 10;
    // 글작성 시간 년/월/일 시:분 
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    HelpBoardDTO dto = new HelpBoardDTO();
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
 
    List articleList = null;
    HelpBoardDAO dbPro = new HelpBoardDAO();
    count = dbPro.getArticleCount();
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, endRow);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .table {
            margin-top: 20px;
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
<div class="container">
    <h1 class="text-center"></h1>
    <div class="text-center mb-4">
        <h2>문의 게시판</h2>
    </div>
    <div class="text-right mb-3">
        <% if(sid != null){ %>
            <a href="write.jsp" class="btn btn-primary">문의하기</a>
        <% } else { %>
            <a href="/project/project02/user/login.jsp" class="btn btn-secondary">로그인 해주세염</a>
        <% } %>
    </div>
    
    <% if (count == 0) { %>
        <div class="alert alert-info text-center">
            게시판에 저장된 글이 없습니다.
        </div>
    <% } else { %>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th width="50">번호</th>
                    <th width="250">제목</th>
                    <th width="100">작성자</th>
                    <th width="150">작성일</th>
                    <th width="80">답변상태</th>
                </tr>
            </thead>
            <tbody>
                <% for (int i = 0; i < articleList.size(); i++) {
                    HelpBoardDTO article = (HelpBoardDTO) articleList.get(i);
                %>
                    <tr>
                        <td><%=article.getNum()%></td>
                        <td class="text-left">
                            <% if (article.getRe_level() > 0) { %>
                                <img src="re.gif">
                            <% } %>
                            
                            <% if (sid.equals(article.getWriter()) || sid.equals("admin")) { %>
                                <a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
                                    <%=article.getSubject()%>
                                </a>
                            <% } else { %>
                                <h6>비밀 글 입니다.</h6>
                            <% } %>    
	                    </td>
	                    
                        <td><%=article.getWriter() %></td>
                        <td><%= sdf.format(article.getReg_date()) %></td>
                        <td>
                            <% if (article.getStatus() == 1) { %>
                                <span class="status-complete">답변완료</span>
                            <% } else { %>
                                <span class="status-pending">-</span>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <% 
                    int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
                    int startPage = (int) (currentPage / 10) * 10 + 1;
                    int pageBlock = 10;
                    int endPage = startPage + pageBlock - 1;
                    if (endPage > pageCount) endPage = pageCount;
                    if (startPage > 10) { %>
                        <li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%=startPage - 10%>">이전</a></li>
                <% }
                    for (int i = startPage; i <= endPage; i++) { %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i%></a>
                        </li>
                <% }
                    if (endPage < pageCount) { %>
                        <li class="page-item"><a class="page-link" href="list.jsp?pageNum=<%=startPage + 10%>">다음</a></li>
                <% } %>
            </ul>
        </nav>
    <% } %>
</div>
</body>
</html>
