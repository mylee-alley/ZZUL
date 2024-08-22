<%@ page import="java.util.Map, java.util.TreeMap, java.util.List, java.util.ArrayList" %>
<%@ page import="java.time.LocalDate, java.time.Year, java.time.YearMonth, java.time.format.DateTimeFormatter, java.time.temporal.WeekFields, java.util.Locale" %>
<%@ page import="web.bean.dao.SalesDAO, web.bean.dto.ReservationDTO,web.bean.dto.RsvtMenuDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
   .hidden{
      display:none;
   }
</style>

<%
SalesDAO sdao = new SalesDAO();
    List<ReservationDTO> slist = sdao.getDefosit();
    Map<Year, Integer> yearlySalesMap = new TreeMap<>();         //월별
    Map<YearMonth, Integer> monthlySalesMap = new TreeMap<>();      //달별
    Map<String, Integer> weeklySalesMap = new TreeMap<>();         //주별
    Map<LocalDate, Integer> dailySalesMap = new TreeMap<>();      //일별
    int yearlySum = 0, monthlySum = 0, weeklySum = 0, dailySum = 0;   //매출합산용변수
    LocalDate nowDate = LocalDate.now();                     //현재시간 
    DateTimeFormatter yearFormatter = DateTimeFormatter.ofPattern("yyyy");      //년별포멧
    DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("yyyy-MM");   //월별포멧
    DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");   //일별포멧   
    WeekFields weekFields = WeekFields.of(Locale.getDefault());               //주별포멧

    for (ReservationDTO rdto : slist) {
        LocalDate visitDate = rdto.getVisit_date().toLocalDateTime().toLocalDate();

        if (visitDate.isBefore(nowDate)) {
            List<RsvtMenuDTO> rsvtList = sdao.getRsvtMenu(rdto);

            for (RsvtMenuDTO rsmdto : rsvtList) {
                int result = sdao.getMenuSales(rsmdto);
                
                Year visitYear = Year.from(visitDate);
                yearlySalesMap.put(visitYear, yearlySalesMap.getOrDefault(visitYear, 0) + result);

                YearMonth visitMonth = YearMonth.from(visitDate);
                monthlySalesMap.put(visitMonth, monthlySalesMap.getOrDefault(visitMonth, 0) + result);
                
                int visitWeek = visitDate.get(weekFields.weekOfWeekBasedYear());
                String weekKey = visitYear + "-W" + visitWeek;
                weeklySalesMap.put(weekKey, weeklySalesMap.getOrDefault(weekKey, 0) + result);
                
                dailySalesMap.put(visitDate, dailySalesMap.getOrDefault(visitDate, 0) + result);
            }
        }
    }
%>
<label><input type="radio" name ="stats" onclick="checkContent(1)" >년별</label>
<label><input type="radio" name ="stats" onclick="checkContent(2)" >월별</label>
<label><input type="radio" name ="stats" onclick="checkContent(3)" >주별</label>
<label><input type="radio" name ="stats" onclick="checkContent(4)" >일별</label>

<div class="content hidden">
   <h2>년별 통계</h2>
   <table border="1">
       <tr>
           <th>연도</th>
           <th>총매출</th>
       </tr>
       <%
       for (Map.Entry<Year, Integer> entry : yearlySalesMap.entrySet()) {
           Year year = entry.getKey();
           int totalSales = entry.getValue();
           yearlySum += totalSales;
       %>
       <tr>
           <td><%= year.format(yearFormatter) %></td>
           <td style="text-align:right"><%= totalSales %>원</td>
       </tr>
       <%
       }
       %>
       <tr>
           <td>매출총액</td>
           <td style="text-align:right"><%= yearlySum %>원</td>
       </tr>
   </table>
</div>

<div class="content hidden">
<h2>월별 통계</h2>
   <table border="1">
       <tr>
           <th>월</th>
           <th>총매출</th>
       </tr>
       <%
       for (Map.Entry<YearMonth, Integer> entry : monthlySalesMap.entrySet()) {
           YearMonth month = entry.getKey();
           int totalSales = entry.getValue();
           monthlySum += totalSales;
       %>
       <tr>
           <td><%= month.format(monthFormatter) %></td>
           <td style="text-align:right"><%= totalSales %>원</td>
       </tr>
       <%
       }
       %>
       <tr>
           <td>매출총액</td>
           <td style="text-align:right"><%= monthlySum %>원</td>
       </tr>
   </table>
</div>

<div class="content hidden">
   <h2>주별 통계</h2>
   <table border="1">
       <tr>
           <th>주</th>
           <th>총매출</th>
       </tr>
       <%
       for (Map.Entry<String, Integer> entry : weeklySalesMap.entrySet()) {
           String week = entry.getKey();
           int totalSales = entry.getValue();
           weeklySum += totalSales;
       %>
       <tr>
           <td><%= week %></td>
           <td style="text-align:right"><%= totalSales %>원</td>
       </tr>
       <%
       }
       %>
       <tr>
           <td>매출총액</td>
           <td style="text-align:right"><%= weeklySum %>원</td>
       </tr>
   </table>
</div>

<div class="content hidden">
   <h2>일별 통계</h2>
   <table border="1">
       <tr>
           <th>일자</th>
           <th>총매출</th>
       </tr>
       <%
       for (Map.Entry<LocalDate, Integer> entry : dailySalesMap.entrySet()) {
           LocalDate day = entry.getKey();
           int totalSales = entry.getValue();
           dailySum += totalSales;
       %>
       <tr>
           <td><%= day.format(dayFormatter) %></td>
           <td style="text-align:right"><%= totalSales %>원</td>
       </tr>
       <%
       }
       %>
       <tr>
           <td>매출총액</td>
           <td style="text-align:right"><%= dailySum %>원</td>
       </tr>
   </table>
</div>

<script>
   function checkContent(connum){
      var contentElements = document.querySelectorAll('.content');
      contentElements.forEach(function(element,index){
         if(index === connum -1){
            element.classList.toggle('hidden');
         }else{
            element.classList.add('hidden');
         }
      });
   }
</script>