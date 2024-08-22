<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.Comparator"%>
<%@ page import="web.bean.dao.ReservationDAO"%>
<%@ page import="web.bean.dto.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" flush="true" />
<jsp:useBean id="reservationDto" class="web.bean.dto.ReservationDTO" />
<jsp:useBean id="reservationDao" class="web.bean.dao.ReservationDAO" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<div style="margin: 0 auto; width: 85%;">
   <h1>예약 정보 목록</h1>

   <input type="button" onclick="goBack()" value="뒤로가기">
   <script>
      function goBack() {
         window.location.href ='/project/project02/home.jsp'
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
   <br><br>
<style>
   table { margin-left:auto; margin-right:auto; }
   a { text-decoration-line: none; color: black;}
</style>

   <table id="reservationTable" border="1" cellpadding="7" cellspacing="1" style="width: 90%;" class="table table-striped;">
      <thead class="table-dark">
         <tr>
            <th onclick="sortTable('reservationTable', 0)">예약번호</th>
            <th onclick="sortTable('reservationTable', 1)">방문자 이름</th>
            <th onclick="sortTable('reservationTable', 2)">예약메뉴</th>
            <th onclick="sortTable('reservationTable', 3)">연락처</th>
            <th onclick="sortTable('reservationTable', 4)">보증금</th>
            <th onclick="sortTable('reservationTable', 5)">방문예약날짜</th>
            <th onclick="sortTable('reservationTable', 6)">인원</th>
            <th width="160">예약상태</th>
            <th >취소사유</th>
            <th >리뷰작성</th>
         </tr>
      </thead>
      <tbody>
<%
         String sid = (String) session.getAttribute("sid");
         List<ReservationDTO> list = reservationDao.getArticle2(sid);

         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

         if (list == null || list.isEmpty()) {
            out.println("예약 정보가 없습니다.");
         } else {
            // 리스트를 방문예약날짜 기준으로 내림차순으로 정렬
            Collections.sort(list, new Comparator<ReservationDTO>() {
               public int compare(ReservationDTO r1, ReservationDTO r2) {
                  // r2가 r1보다 앞에 오도록 내림차순으로 정렬
                  return r2.getVisit_date().compareTo(r1.getVisit_date());
               }
            });

            for (int i = 0; i < list.size(); i++) {
               ReservationDTO article2 = list.get(i);
               List<String> menuList = reservationDao.getMenuList(article2.getRsvt_id());
%>
         <tr>
            <td><%=article2.getRsvt_id()%></td>
            <td><%=article2.getRsvt_name()%></td>
            <td>
               <ol>
<%
                  for (String menu : menuList) {
%>
                     <li><%=menu%></li>
<%
                  }
%>
               </ol>
            </td>
            <td><%=article2.getRsvt_phon()%></td>
            <td><%=article2.getDeposit()%></td>
            <td><%=sdf.format(article2.getVisit_date())%></td>
            <td><%=article2.getRsvt_head_count()%></td>
<%
            if (article2.getRsvt_status() == 0) {
               String stt = "예약취소 완료";
%>
            <td><%=stt%></td>
<%
            } else if (article2.getRsvt_status() == 1) {
               String stt = "예약";
%>
            <td  width=""><%=stt%>
               <form action="bkCanclePopup.jsp" onclick="_blank" method="post" style="display: inline;">
                  <input type="hidden" name="getRsvt_id" value="<%=article2.getRsvt_id()%>" />
                  <input type="hidden" name="visit_date" value="<%=article2.getVisit_date()%>" />
                   <input type="hidden" name="visit_time" value="<%=article2.getVisit_time()%>" />
                  <input type="hidden" name="rsvt_name" value="<%=article2.getRsvt_name()%>" />
                  <input type="hidden" name="menu[]" value="<%=menuList%>" />
                  <input type="hidden" name="rsvt_head_count" value="<%=article2.getRsvt_head_count()%>" />
<%
                  LocalDateTime localDateTime = LocalDateTime.now();
                  Timestamp timestamp = Timestamp.valueOf(localDateTime);
                  Timestamp anotherTimestamp = article2.getVisit_date();
                  if (timestamp.before(anotherTimestamp)) {
%>
                  <input type="submit" value="예약취소" class="btn btn-secondary"/>
<%
                  } else if (timestamp.after(anotherTimestamp)) {
%>
                  <p><b>(예약취소불가)</b></p>
<%
                  }
%>
               </form></td>
               <%} %>
            <td><%= (article2.getRsvt_cncl_reason() != null) ? article2.getRsvt_cncl_reason() : "" %></td>
            <td>
               <form action="/project/project02/review/writeForm.jsp" method="post">
<%
                  for (String menu : menuList) {
%>
                     <input type="hidden" name="menu[]" value="<%=menu%>">
<%
                  }
%>
                  <input type="hidden" name="rsvt_id" value="<%=article2.getRsvt_id()%>" />
<%
                     LocalDateTime localDateTime1 = LocalDateTime.now();
                     Timestamp timestamp1 = Timestamp.valueOf(localDateTime1);
                     Timestamp anotherTimestamp1 = article2.getVisit_date();
                     if (article2.getReview() == 0) {
                        if (timestamp1.after(anotherTimestamp1)) {
%>
                           <input type="submit" value="리뷰 작성" class="btn btn-secondary"/>
<%
                        } else {
%>
                           작성 기간이 아닙니다.
<%
                        }
                     } else {
%>
                           작성 완료
<%
                     }
%>
               </form>
            </td>
         </tr>
<%
               
            }
         }
%>
      </tbody>
   </table>
</div>