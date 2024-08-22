<%@ page import="java.util.HashMap, java.util.Map, java.util.TreeMap, java.util.List, java.util.ArrayList, java.time.LocalDate" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="web.bean.dao.SalesDAO, web.bean.dto.ReservationDTO,web.bean.dto.RsvtMenuDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>

<%

    SalesDAO sdao = new SalesDAO();
    List<ReservationDTO> slist = sdao.getDefosit();
    Map<String, Integer> salesMap = new TreeMap<>();
    int sum = 0;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    LocalDate nowDate = LocalDate.now();

    for (ReservationDTO rdto : slist) {
        LocalDate visitDate = rdto.getVisit_date().toLocalDateTime().toLocalDate();

        if (visitDate.isBefore(nowDate)) {
            List<RsvtMenuDTO> rsvtList = sdao.getRsvtMenu(rdto);

            for (RsvtMenuDTO rsmdto : rsvtList) {
                int result = sdao.getMenuSales(rsmdto);
                salesMap.put(rsmdto.getMenu(), salesMap.getOrDefault(rsmdto.getMenu(), 0) + result);
            }
        }
    }
%>
<table border="1">
    <tr>
        <th>메뉴</th>
        <th>총매출</th>
        <th></th>
    </tr>

    <%
    for (Map.Entry<String, Integer> entry : salesMap.entrySet()) {
        String menu = entry.getKey();
        int totalSales = entry.getValue();
        sum += totalSales;
    %>
    <tr>
        <td><%= menu %></td>
        <td style="text-align:right"><%= totalSales %>원</td>
        <td></td>
    </tr>
    <%
    }
    %>
    <tr>
        <td>매출총액</td>
        <td style="text-align:right"><%= sum %>원</td>
        <td><a href="../sales/salesDay.jsp?">년,월,주,일 통계</a></td>
    </tr>
</table>