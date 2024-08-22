<%@page import="web.bean.dto.MgRsvtDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MgRsvtDAO" />
<style>
	.list_table { margin-left:auto; margin-right:auto; }
	tr { height: 40px;}
	.disnone {display: block;}
</style>
<script>
	yn = document.getElementById("rsvt_psblty_yn").value;
	if(yn == "N"){
		document.getElementById("disnone").style.display="none";
	} else {
		document.getElementById("disnone").style.display="block";
	}
	function psbltyChange(){
		console.log("psbltyChange");
		yn = document.getElementById("rsvt_psblty_yn").value;
		if(yn == "N"){
			document.getElementById("disnone").style.display="none";
		} else {
			document.getElementById("disnone").style.display="block";
		}
	}
</script>
<%
	String date = request.getParameter("date");
	System.out.println("date ::: " + date);
	MgRsvtDTO result = new MgRsvtDTO();
	result = dao.getRsvtDay(date);
	
// 	if(date > today){
		
// 	}
%>
<br />
<br />
<br />
<form action="mgRsvtSelectDayPro.jsp" method="post">
	<table class="list_table" >
		<input type="hidden" name="date_value" value="<%=result.getDate_value().substring(0,10) %>" />
		<input type="hidden" name="mg_head_count_max" value="<%=result.getMg_head_count_max() %>" />
		<input type="hidden" name="mg_head_count_min" value="<%=result.getMg_head_count_min() %>" />
		<tr>
			<td width="100">일자</td><td width="200"><%=result.getDate_value().substring(0,10) %></td>
			<td width="100">예약금</td><td width="200"><input type="text" name="deposit" value="<%=result.getDeposit() %>" /></td>
		</tr>
		<tr>
			<td>영업상태</td>
			<td>
<%
			String psYn = result.getRsvt_psblty_yn();
			String strPsYn = "";
			if(psYn.equals("Y")) {
%>
				정상영업<input type="radio" name="rsvt_psblty_yn" value="Y" checked="checked" />
				휴무일<input type="radio" name="rsvt_psblty_yn" value="N" /><br />
<%
			} else if (psYn.equals("N")){
%>
				정상영업<input type="radio" name="rsvt_psblty_yn" value="Y" onclick="psbltyChange()" />
				휴무일<input type="radio" name="rsvt_psblty_yn" value="N" checked="checked" /><br />
<%
			}
%>
			</td>
<%
				String exp = result.getExplain();
				if(exp == null || exp.equals("null")){
					exp = "";
				}
				String t1 = result.getRsvt_t1();
				if(t1 == null || t1.equals("null")){
					t1 = "";
				}
				String t2 = result.getRsvt_t2();
				if(t2 == null || t2.equals("null")){
					t2 = "";
				}
				String t3 = result.getRsvt_t3();
				if(t3 == null || t3.equals("null")){
					t3 = "";
				}
				String t4 = result.getRsvt_t4();
				if(t4 == null || t4.equals("null")){
					t4 = "";
				}
				String t5 = result.getRsvt_t5();
				if(t5 == null || t5.equals("null")){
					t5 = "";
				}
%>
			<td>내용</td><td><input type="text" name="explain" value="<%=exp %>"/></td>
		</tr>
		<table class="list_table" name="disnone" >
<!-- 		<div name="disnone"> -->
			<tr>
				<td>예약시간1</td><td><input type="text" name="rsvt_t1" value="<%=t1 %>" /></td>
				<td>예약최대인원</td><td><input type="number" name="rsvt_t1_head_max" value="<%=result.getRsvt_t1_head_max() %>" /></td>
			</tr>
			<tr>
				<td>예약시간2</td><td><input type="text" name="rsvt_t2" value="<%=t2 %>" /></td>
				<td>예약최대인원</td><td><input type="number" name="rsvt_t2_head_max" value="<%=result.getRsvt_t2_head_max() %>" /></td>
			</tr>
			<tr>
				<td>예약시간3</td><td><input type="text" name="rsvt_t3" value="<%=t3 %>" /></td>
				<td>예약최대인원</td><td><input type="number" name="rsvt_t3_head_max" value="<%=result.getRsvt_t3_head_max() %>" /></td>
			</tr>
			<tr>
				<td>예약시간4</td><td><input type="text" name="rsvt_t4" value="<%=t4 %>" /></td>
				<td>예약최대인원</td><td><input type="number" name="rsvt_t4_head_max" value="<%=result.getRsvt_t4_head_max() %>" /></td>
			</tr>
			<tr>
				<td>예약시간5</td><td><input type="text" name="rsvt_t5" value="<%=t5 %>" /></td>
				<td>예약최대인원</td><td><input type="number" name="rsvt_t5_head_max" value="<%=result.getRsvt_t5_head_max() %>" /></td>
			</tr>
<!-- 		</div> -->
	</table>
	<br />
	<div style="text-align: center">
		<input class="list_table" type="submit" value="수정" />
	</div>
</form>



