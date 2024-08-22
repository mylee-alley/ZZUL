<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="web.bean.dto.MemberDTO"%>
<%@page import="web.bean.dao.MemberDAO"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="memberDTO" class="web.bean.dto.MemberDTO" />
<jsp:useBean id="memberDAO" class="web.bean.dao.MemberDAO" />
<jsp:include page="../header.jsp" flush="true"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<%
   List<MemberDTO> memberList = memberDAO.getAllMembers();

   // 등급별 인원수 계산
   int familyCount = 0;
   int goldCount = 0;
   int diaCount = 0;
   int companyCount = 0;
   
   for (MemberDTO member : memberList) {
       switch (member.getUser_grade()) {
           case 0: familyCount++; break;
           case 1: goldCount++; break;
           case 2: diaCount++; break;
           case 4: companyCount++; break;
       }
   }
   int totalCount = memberList.size();
%>
<style>
   table { margin-left:auto; margin-right:auto; }
   a { text-decoration-line: none; color: black;}
</style>


<div style="margin:auto; width: 60%; display: flex; justify-content: space-between;">
    <!-- 검색 부분 -->
    <div style="width: 48%;">
        <form method="post" action="gradeManagingMain.jsp">
            이름: <input type="text" name="name"> <input type="submit" value="조회하기"><br><br>
            <input type="button" onclick="goBack()" value="뒤로가기">
        </form>
        <script>
            function goBack() {
                window.location.href = '/project/project02/home.jsp';
            }
            
            /* 테이블의 각 컬럼 오름차순 내림차순 설정 */
            function sortTable(tableId, colIndex) {
               const table = document.getElementById(tableId);
               const rows = table.rows;
               let switching = true;
               let shouldSwitch, i, x, y;
               let order = table.getAttribute('data-order') || 'asc';
               table.setAttribute('data-order', order === 'asc' ? 'desc' : 'asc');
               
               while (switching) {
                  switching = false;
                  for (i = 1; i < (rows.length - 1); i++) {
                     shouldSwitch = false;
                     x = rows[i].getElementsByTagName("TD")[colIndex];
                     y = rows[i + 1].getElementsByTagName("TD")[colIndex];
                     if (order === 'asc') {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                           shouldSwitch = true;
                           break;
                        }
                     } else if (order === 'desc') {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                           shouldSwitch = true;
                           break;
                     }
                  }
               }
                  if (shouldSwitch) {
                     rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                     switching = true;
                  }
               }
            }           
        </script>
    </div>


    <!-- 등급별 인원수 및 전체 인원수 표시 -->
    <div style="width: 48%;">
   
        <table border="1" cellpadding="7" cellspacing="1" style="width: 70%;" class="table table-striped">
            <thead class="table-dark">
            <tr>
                <th>등급</th>
                <th>인원수</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Famliy</td>
                <td><%= familyCount %> 명</td>
            </tr>
            <tr>
                <td>Gold</td>
                <td><%= goldCount %> 명</td>
            </tr>
            <tr>
                <td>Dia</td>
                <td><%= diaCount %> 명</td>
            </tr>
            <tr>
                <td>Conpany</td>
                <td><%= companyCount %> 명</td>
            </tr>
            <tr>
                <td>전체</td>
                <td><%= totalCount %> 명</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%
    String name = request.getParameter("name"); // 사용자가 입력한 이름 가져오기
    System.out.print(name);
    if (name != null && !name.isEmpty()) { // 이름이 입력되었을 경우
        memberList = memberDAO.searchMembers(name); // 회원 검색
    } else { // 이름이 입력되지 않았을 경우 전체 회원 목록 표시
        memberList = memberDAO.getAllMembers();
    }

    // 검색 결과 등급별 인원수 재계산
    familyCount = 0;
    goldCount = 0;
    diaCount = 0;
    companyCount = 0;

    for (MemberDTO member : memberList) {
        switch (member.getUser_grade()) {
            case 0: familyCount++; break;
            case 1: goldCount++; break;
            case 2: diaCount++; break;
            case 4: companyCount++; break;
        }
    }
    totalCount = memberList.size();
%>

<!-- 회원 목록 테이블 -->
<div style="width: 75%; margin: 50px auto;">
    <table id="memberInfoTable" border="1" cellpadding="7" cellspacing="1" style="width: 80%;" class="table table-striped">
      <thead class="table-dark">
            <tr>
                <th onclick="sortTable('memberInfoTable', 0)">ID</th>
                <th onclick="sortTable('memberInfoTable', 0)">이름</th>
                <th onclick="sortTable('memberInfoTable', 0)">전화번호</th>
                <th onclick="sortTable('memberInfoTable', 0)">이메일</th>
                <th onclick="sortTable('memberInfoTable', 0)">예약횟수</th>
                <th onclick="sortTable('memberInfoTable', 0)">활성화 상태</th>
                <th onclick="sortTable('memberInfoTable', 6)">등급</th>
            </tr>
        </thead>
        <tbody>
        <%
            // 회원 정보 표시하고, 숫자등급을 문자로 바꿔줌
            for (MemberDTO member : memberList) {
           String grade = ""; // 기본 등급
              int currentGrade = member.getUser_grade();
              if (currentGrade == 4) {
                  grade = "Company";
              } else if (currentGrade == 2) {
                  grade = "Dia";
              } else if (currentGrade == 1) {
                  grade = "Gold";
              } else if (currentGrade == 0) {
                  grade = "Family";
              }
        %>
            <!-- 위 해당하는 사람을 선택하여 다음 페이지로 등급 정보를 보내서 출력, 등급 변경 버튼을 추가 -->
            <tr>
                <td><%= member.getId() %></td>
                <td><%= member.getName() %></td>
                <td><%= member.getPhone() %></td>
                <td><%= member.getEmail() %></td>
                <td><%= member.getBook_count() %></td>
                <td><%= member.getActive() == 1 ? "활성화" : "비활성화" %></td>
                <td colspan="2"><%= grade %>
                    <!-- 등급 변경 버튼 -->
                    <form action="gradeChange.jsp" method="GET" style="display:inline">
                        <input type="hidden" name="id" value="<%= member.getId() %>">
                        <input type="hidden" name="currentGrade" value="<%=currentGrade%>">
                        <input type="submit" value="등급 변경">
                    </form>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</div>