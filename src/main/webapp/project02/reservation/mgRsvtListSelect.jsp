<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.bean.dto.ReservationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true" />
<jsp:useBean id="mgdao" class="web.bean.dao.MgRsvtDAO" />
<jsp:useBean id="mgdto" class="web.bean.dto.MgRsvtDTO" />
<jsp:useBean id="dao" class="web.bean.dao.ReservationDAO" />
<jsp:useBean id="dto" class="web.bean.dto.ReservationDTO" />
<jsp:useBean id="memberdao" class="web.bean.dao.MemberDAO" />
<jsp:useBean id="memberdto" class="web.bean.dto.MemberDTO" />
<style>
	.list_table { margin-left:auto; margin-right:auto; }
	tr { height: 40px;}
	.disnone {display: block;}
</style>
<script>

</script>
<%
	String rsvtId="" ;
	if(request.getParameter("rsvt_id") != null){
		rsvtId = request.getParameter("rsvt_id");
	}

	System.out.println("myRsvtListSelect.jsp rsvtId ::: " + request.getParameter("rsvt_id"));
	System.out.println("myRsvtListSelect.jsp rsvtId ::: " + rsvtId);
	dto = dao.getOneReservation(rsvtId);
	List rsvtMenuList = null;
	rsvtMenuList = dao.getUserRsvtMenu(rsvtId);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	
	String userGrade = "";
	if(dto.getUser_id() == null || dto.getUser_id().equals("")){
		userGrade = "비회원";
	} else {
		memberdto = memberdao.member(dto.getUser_id());
		int grade = memberdto.getUser_grade();
		if (grade == 2) {
			userGrade = "Dia";
	    } else if (grade == 1) {
	    	userGrade = "Gold";
	    } else if (grade == 0) {
	    	userGrade = "Family";
	    }
	}
	
	String rsvtStt="" ;
	System.out.println("myRsvtListSelect.jsp rsvt_status ::: " + dto.getRsvt_status());
	if(dto.getRsvt_status() == 1 ) {
		rsvtStt = "예약";
	} else {
		rsvtStt = "예약취소";
	}
	
	String DepositPayby = "";
	int payby = dto.getDeposit_payby();
	if(payby == 1) {
		DepositPayby = "카드결제";
	}
	
	String resonStr = "";
	if(dto.getRsvt_cncl_reason() == null || dto.getRsvt_cncl_reason().equals("") ){
		resonStr = "";
	} else {
		resonStr = dto.getRsvt_cncl_reason();
	}
	
%>
<br />
<br />
<br />
<table class="list_table" border="1" >
	<tr align="center" >
		<th width="130" > 방문일자	</th>
		<th width="130" > 방문시간	</th>
		<th width="130" > 예약자명	</th>
		<th width="130" > 전화번호	</th>
		<th width="130" > 회원등급	</th>
		<th width="130" > 총인원수 </th>
		<th width="130" > 예약금 </th>
		<th width="130" > 결제방식 </th>
		<th width="130" > 결제일시 </th>
	</tr>
	<tr align="center" >
		<td><%=sdf.format(dto.getVisit_date())	%></td>
		<td><%=dto.getVisit_time()     			%></td>
		<td><%=dto.getRsvt_name()       		%></td>
		<td><%=dto.getRsvt_phon()       		%></td>
		<td><%=userGrade 				%></td>
		<td><%=dto.getRsvt_head_count()	%>명</td>
		<td><%=dto.getDeposit()         %>원</td>
		<td><%=DepositPayby             %></td>
		<td><%=dto.getRsvt_date()       %></td>
	</tr>
</table>
<br />
<table class="list_table" border="1" >
	<tr>
		<th width="130" > 예약상태 </th>
		<th width="530" > 예약취소사유 </th>
	</tr>
	<tr align="center" >
		<td><%=rsvtStt     				%></td>
		<td><%=resonStr%></td>
	</tr>
</table>
<br />
<table class="list_table" border="1">
	<tr align="center" >
		<th width="530" >예약 메뉴</th>
		<th width="130" >수량</th>
	</tr>
<%
	for (int i = 0; i < rsvtMenuList.size(); i++){
		dto = (ReservationDTO)rsvtMenuList.get(i);
%>
	<tr>
		<td><%=dto.getMenu() %></td>
		<td align="center" ><%=dto.getCount() %></td>
	</tr>
<%
	}
%>
</table>
<br />
