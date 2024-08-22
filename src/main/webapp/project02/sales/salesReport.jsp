<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeParseException"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="web.bean.dao.SalesDAO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>

    <title>매출 통계</title>

    <h1>일별 매출통계</h1>
    <table border="1">
        <tr>
            <th>일</th>
            <th>매출</th>
            
        </tr>
        <% 
        	Map<String, Integer> dailyTotalSales = new HashMap<>();
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        	SalesDAO sdao = new SalesDAO();
        	LocalDate nowDate = LocalDate.now();
            Map<String, Integer> dailySales = (HashMap<String, Integer>)request.getAttribute("dailySales");
        	Map<String, Integer> sortedDailySales = new TreeMap<>(dailySales);
        	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
            for(String date : sortedDailySales.keySet()) {
            	LocalDate visitDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
            	if (visitDate.isBefore(nowDate)) {
            		// 입력 문자열을 Date 객체로 파싱
                    Date dateFormat = inputFormat.parse(date);
                    // Date 객체를 원하는 형식으로 포맷
                    String formattedDate = outputFormat.format(dateFormat);
        %>
        <tr>
            <td><%= formattedDate %></td>
            <td style="text-align:right"><%= dailySales.get(date) %>원</td>
        </tr>
<% 				}
            }
%>
    </table>
    
    <h1>월별매출통계</h1>
    <table border="1">
        <tr>
            <th>월</th>
            <th>매출</th>
          
        </tr>
        <% 
            Map<String, Integer> monthlySales = (Map<String, Integer>)request.getAttribute("monthlySales");
       		Map<String, Integer> sortedmonthlySales = new TreeMap<>(monthlySales);
            for (String month : sortedmonthlySales.keySet()) {
            	 if (LocalDate.parse(month + "-01").isBefore(nowDate)) {
        %>
        <tr>
            <td><%= month %></td>
            <td style="text-align:right"><%= monthlySales.get(month) %>원</td>
        </tr>
<%       		 }
            } %>
    </table>
    
    <h1>년별 매출 통계</h1>
    <table border="1">
        <tr>
            <th>년</th>
            <th>매출</th>

        </tr>
        <% 
            Map<String, Integer> yearlySales = (Map<String, Integer>)request.getAttribute("yearlySales");
        	Map<String, Integer> sortedyearlySales = new TreeMap<>(yearlySales);
            for (String year : yearlySales.keySet()) {
            	if (LocalDate.parse(year + "-01-01").isBefore(nowDate)) {
        %>
        <tr>
            <td><%= year %></td>
            <td style="text-align:right"><%= yearlySales.get(year) %>원</td>
        </tr>
<% 				}
            	
    		}%>
    </table>
