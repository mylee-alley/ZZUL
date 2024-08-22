<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.MenuDTO"%>
<%@ page import="web.bean.dao.MenuDAO"%>
<%@ page import="java.util.List"%>
<jsp:include page="../header.jsp" flush="true" />
<%@ page import="web.bean.dto.MgRsvtDTO"%>
<%@ page import="java.sql.Timestamp"%>
<jsp:useBean id="mgdao" class="web.bean.dao.MgRsvtDAO" />
<jsp:useBean id="mgdto" class="web.bean.dto.MgRsvtDTO" />
<jsp:useBean id="rsvtdto" class="web.bean.dto.ReservationDTO" />
<jsp:useBean id="rsvtdao" class="web.bean.dao.ReservationDAO" />
<style>
	table { margin-left:auto; margin-right:auto; }
</style>
<script>

	// 예약일자 선택시 해당일자 예약 가능 시간 및 예약금 조회
	function selectDay() {
		console.log("selectDay()");
		vday = document.getElementById("visit_date").value;
		console.log("selectDay() vday ::: " + vday);
		window.location = ("reservePro.jsp?dvsn=time&visit_time="+vday);
	}
	function test(str1){
		var fm = document.rsForm;
		var name = str1.options[str1.options.selectedIndex].getAttribute("name");
		fm.i_code.value = name;
	}
	// 예약시간 선택시 해당일자 예약 가능 인원 조회
	var head="";
	var rsvtTimeNum = "1";
	function selectTime(sb1) {
		const selectBox = document.querySelector('#visit_time');
		const selectedOption = selectBox.options[selectBox.selectedIndex];
		const value = selectedOption.value;
		var name = sb1.options[sb1.options.selectedIndex].getAttribute("name");
		const text = selectedOption.text;
		
// 		rsvt_t1_head_max
		console.log("selectTime() name ::: " + name);
		var overhd = name + "_head_max";
		console.log("111 selectTime() document.getElementById(overhd).value ::: " + document.getElementById(overhd).value);
		
// 		document.getElementById("overhd").value = document.getElementById(overhd).value;
		console.log("selectTime() overhd ::: " + overhd);
// 		console.log("selectTime() document.getElementById('overhd').value ::: " + document.getElementById("overhd").value);
// 		console.log("selectTime() document.getElementById(overhd).value; ::: " + document.getElementById(overhd).value;);
		
		if(name = "rsvt_t1"){
			rsvtTimeNum = "1";
			head = document.getElementById("rsvt_t1_head_max").value;
		} else if(name = "rsvt_t2"){
			rsvtTimeNum = "2";
			head = document.getElementById("rsvt_t2_head_max").value;
		} else if(name = "rsvt_t3"){
			rsvtTimeNum = "3";
			head = document.getElementById("rsvt_t3_head_max").value;
		} else if(name = "rsvt_t4"){
			rsvtTimeNum = "4";
			head = document.getElementById("rsvt_t4_head_max").value;
		} else if(name = "rsvt_t5"){
			rsvtTimeNum = "5";
			head = document.getElementById("rsvt_t5_head_max").value;
		}
		document.getElementById("rsvtTimeNum").value = rsvtTimeNum;
		
		console.log("selectTime() head ::: " + head);
		console.log("selectTime() text ::: " + text);
		console.log("selectTime() selectBox ::: " + selectBox.value);
		console.log("selectTime() selectedOption ::: " + selectedOption.value);
		console.log("selectTime() value ::: " + value);
		
		
		vday = document.getElementById("visit_date").value;
// 		window.location = ("reservePro.jsp?dvsn=time&visit_time="+vday);
	}
	
	// 인원수 입력시 해당시간 예약 가능 인원 체크 하지말까....이거....
	function selectHeadCount() {
		rhc = document.getElementById("rsvt_head_count").value;
		vtimee = document.getElementById("visit_time");
		vtime = document.getElementById("visit_time").value;
		
		// 토글 할 버튼 선택 (btn1)
		const btn1 = document.getElementById("submitBtn");
		
		if(parseInt(head)< parseInt(rhc)){
			alert("예약 가능 인원수를 초과하셨습니다");
			btn1.style.display = 'none';
			document.getElementById("rsvt_head_count").value = '';
			document.getElementById("rsvt_head_count").focus();
		} else {
			
			btn1.style.display = 'block';
		}
	}

	// 메뉴별 수량 입력시
	function sumMenuCount(){
		console.log("sumMenuCount");
		num = 0;
		headcount = Number(document.getElementById("rsvt_head_count").value);
		if(headcount == null || headcount ==0){
			alert("인원수를 입력해주세요");
			document.getElementById("select_menu_count_1").value = '';
			document.getElementById("select_menu_count_2").value = '';
			document.getElementById("select_menu_count_3").value = '';
			document.getElementById("select_menu_count_4").value = '';
			document.getElementById("select_menu_count_5").value = '';
			document.getElementById("rsvt_head_count").focus();
		} else {
			menuListSize = Number(document.getElementById("menuListSize").value);
			for(var i=0; i<menuListSize; i++){
				mci = "select_menu_count_"+ (i+1);
				num += Number(document.getElementById(mci).value);
			}
			if(num > headcount ){
				alert("1인당 1메뉴만 주문 가능합니다. 가게에 문의 부탁드립니다.");
			}
		}
	}
</script>
<%
	String sid = (String) session.getAttribute("sid");
	List dateList = mgdao.rsvtDate();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String nowTime="";
	String deposit="";
	try {
		nowTime = request.getParameter("visit_date");
		if(nowTime == null){
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, 1);		// 내일 날짜 구하기
			Date now = cal.getTime();
			nowTime = now.toString();
			nowTime = sdf.format(now);
		} else {
			deposit = request.getParameter("deposit");
			nowTime = request.getParameter("visit_date");
			mgdto.setRsvt_t1(request.getParameter("rsvt_t1"));
			mgdto.setRsvt_t2(request.getParameter("rsvt_t2"));
			mgdto.setRsvt_t3(request.getParameter("rsvt_t3"));
			mgdto.setRsvt_t4(request.getParameter("rsvt_t4"));
			mgdto.setRsvt_t5(request.getParameter("rsvt_t5"));
			mgdto.setRsvt_t1_head_max(Integer.parseInt(request.getParameter("rsvt_t1_head_max")));
			mgdto.setRsvt_t2_head_max(Integer.parseInt(request.getParameter("rsvt_t2_head_max")));
			mgdto.setRsvt_t3_head_max(Integer.parseInt(request.getParameter("rsvt_t3_head_max")));
			mgdto.setRsvt_t4_head_max(Integer.parseInt(request.getParameter("rsvt_t4_head_max")));
			mgdto.setRsvt_t5_head_max(Integer.parseInt(request.getParameter("rsvt_t5_head_max")));
			mgdto.setDeposit(request.getParameter("deposit"));
			
			nowTime = nowTime.substring(0, 10);
			
		}
	} catch(Exception e){
		e.printStackTrace();
	}
	mgdto = mgdao.getRsvtDay(nowTime);
%>
<form action="reservePro.jsp?dvsn=reserve" method="post">
	<input type="hidden" name="user_id" value=<%=sid%>>
	<input type="hidden" name="rsvtTimeNum" >
	<table >
		<tr>
			<td> 원하시는 예약 날짜 </td>
			<td>
				<select id="visit_date" name="visit_date" onchange="selectDay()" style="width: 158">
<%
					for (int i = 0; i < dateList.size(); i++) {
						MgRsvtDTO dto = (MgRsvtDTO) dateList.get(i);
						if(dto.getDate_value().substring(0, 10).equals(nowTime)){
							String dstr = dto.getDate_value().substring(0, 10);
%>
							<option value="<%=dstr%>" selected="selected">
								<%=dto.getDate_value().substring(0, 10)%>
							</option>
<%
						} else {
%>
							<option value="<%=dto.getDate_value().substring(0, 10)%>">
								<%=dto.getDate_value().substring(0, 10)%>
							</option>
<%							
						}
					}
%>
				</select>
			</td>
		</tr>
		<tr>
			<td> 원하시는 예약 시간 </td>
			<td>
				<select id="visit_time" name="visit_time" style="width: 158" onchange="javascript:selectTime(this)">
					<% if(mgdto.getRsvt_t1() == null){ %>
						<option >영업휴무</option>
					<%} else {
						if(mgdto.getRsvt_t1() != null || mgdto.getRsvt_t1() != "null"){ %>
							<option name="rsvt_t1" value="<%=mgdto.getRsvt_t1()%>"><%=mgdto.getRsvt_t1()%></option>
						<%}
						if(mgdto.getRsvt_t2() != null){ %>
							<option name="rsvt_t2" value="<%=mgdto.getRsvt_t2()%>"><%=mgdto.getRsvt_t2()%></option>
						<%}
						if(mgdto.getRsvt_t3() != null){ %>
							<option name="rsvt_t3" value="<%=mgdto.getRsvt_t3()%>"><%=mgdto.getRsvt_t3()%></option>
						<%}
						if(mgdto.getRsvt_t4() != null){ %>
							<option name="rsvt_t4" value="<%=mgdto.getRsvt_t4()%>"><%=mgdto.getRsvt_t4()%></option>
						<%}
						if(mgdto.getRsvt_t5() != null){ %>
							<option name="rsvt_t5" value="<%=mgdto.getRsvt_t5()%>"><%=mgdto.getRsvt_t5()%></option>
						<%}
					}%>
				</select><br> 
			</td>
		</tr>
		<input type="hidden" id="rsvt_t1_head_max" name="rsvt_t1_head_max" value="<%=mgdto.getRsvt_t1_head_max() %>" />
		<input type="hidden" id="rsvt_t2_head_max" name="rsvt_t2_head_max" value="<%=mgdto.getRsvt_t2_head_max() %>" />
		<input type="hidden" id="rsvt_t3_head_max" name="rsvt_t3_head_max" value="<%=mgdto.getRsvt_t3_head_max() %>" />
		<input type="hidden" id="rsvt_t4_head_max" name="rsvt_t4_head_max" value="<%=mgdto.getRsvt_t4_head_max() %>" />
		<input type="hidden" id="rsvt_t5_head_max" name="rsvt_t5_head_max" value="<%=mgdto.getRsvt_t5_head_max() %>" />
		<input type="hidden" id="overhd" name="overhd" value="" />
		<tr>
			<td> 예약자 성함 </td>
			<td><input type="text" name="rsvt_name"></td>
		</tr>
		<tr>
			<td> 전화번호 </td>
			<td><input type="tel" name="rsvt_phon"></td>
		</tr>
		<tr>
			<td> 인원수 </td>
			<td><input type="number" id="rsvt_head_count" name="rsvt_head_count" onkeyup="selectHeadCount()"></td>
		</tr>
		<% if(mgdto.getRsvt_t1() != null){ %>
		<tr><td colspan="2" align="right" ><input id="submitBtn" type="submit" value="예약하기" style="display: none"/></td></tr>
		<%} %>
	</table>
	<br />
	<table>
		<tr style="text-align: center;">
			<td colspan="2"> 메뉴 </td><td> 가격 </td><td> 선택 </td><td> 수량 </td>
<%
// 				MenuDAO menudao = new MenuDAO();
				List menus = rsvtdao.getOnMenu();
%>
		</tr>
<%
		String menuName = "";
		String menucName = "";
		for (int i = 0; i < menus.size(); i++) {
			MenuDTO menudto = (MenuDTO) menus.get(i);
			menuName = "select_menu_" + (Integer.toString(i + 1));
			menucName = "select_menu_count_" + (Integer.toString(i + 1));
%>
			<input type="hidden" id="deposit" name="deposit" value="<%=deposit%>" />
			<input type="hidden" id="menuListSize" name="menuListSize" value="<%=menus.size()%>" />
			<tr>
				<td><img alt="메뉴사진" src="/project/resources/image/menu/<%=menudto.getImg()%>" width="200" height="150" /></td>
				<td><%=menudto.getName()%></td>
				<td><%=menudto.getPrice()%>원 </td>
				<td><input type="checkbox" id="<%=menuName %>" name="select_menu" value="<%=Integer.toString(i + 1)+"-"+menudto.getName() %>" /></td>
				<td><input type="number" id="<%=menucName %>" name="<%=menucName %>" onkeyup="sumMenuCount()" /></td>
			</tr>
<%
		}
%>
		<tr>
<%-- 			<td>총 수량 : </td><td><%=num %></td> --%>
		</tr>
<!-- 					<input type="number" id="" max="60" min="0" /> -->
<!-- 					<input type="button" value="메뉴추가하기" onclick="addMenu();" /><br /> -->
		
	</table>
	<br />
	<br />
	<br />
</form>
