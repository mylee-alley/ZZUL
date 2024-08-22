<%@page import="web.bean.dao.ReservationDAO"%>
<%@page import="web.bean.dao.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="web.bean.dto.ReservationDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.bean.dao.SalesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 		SalesDAO sdao = new SalesDAO();
        List<ReservationDTO> slist = sdao.getDefosit();
        ReservationDTO rdto = new ReservationDTO();
        ReservationDAO rdao = new ReservationDAO();
        // 그룹화된 데이터를 저장할 Map
        Map<String, Integer> dailySales = new HashMap<>();
        Map<String, Integer> monthlySales = new HashMap<>();
        Map<String, Integer> yearlySales = new HashMap<>();
        
        // 일별, 월별, 년도별로 판매 데이터를 그룹화
        for (ReservationDTO dto : slist) {
            Timestamp date = dto.getVisit_date();
            int deposit = Integer.parseInt(dto.getDeposit());

            // String.valueOf()를 사용하여 기본적인 형식으로 변환
            String formattedDate = String.valueOf(date);
            // 일별
            dailySales.put(formattedDate, dailySales.getOrDefault(date, 0) + deposit);
            // 월별
            String month = formattedDate.substring(0, 7);
            monthlySales.put(month, monthlySales.getOrDefault(month, 0) + deposit);
            // 년도별
            String year = formattedDate.substring(0, 4);
            yearlySales.put(year, yearlySales.getOrDefault(year, 0) + deposit);
        }
        
        // 데이터를 JSP에 전달
        request.setAttribute("dailySales", dailySales);
        request.setAttribute("monthlySales", monthlySales);
        request.setAttribute("yearlySales", yearlySales);
        
        // JSP로 포워딩
        request.getRequestDispatcher("/project02/sales/salesReport.jsp").forward(request, response);
    
 %>