<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.bean.dto.MgRsvtDTO"%>
<%@page import="web.bean.dto.MenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.bean.dao.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="mgrsvtdto" class="web.bean.dto.MgRsvtDTO" />
<%-- <jsp:setPropoerty name="mgrsvtdto" property="*" /> --%>
<jsp:useBean id="mgrsvtdao" class="web.bean.dao.MgRsvtDAO" />
<jsp:useBean id="menudto" class="web.bean.dto.MenuDTO" />
<jsp:useBean id="menudao" class="web.bean.dao.MenuDAO" />
<style>
	.list_table { margin-left:auto; margin-right:auto; }
	form {  }
	span { margin-left:auto; margin-right:auto; }
 	.cng_th { text-align: left; }
	.list_table tr td { text-align: center; }
	a { text-decoration-line: none; }
	th .addbtn { width:60px; }
</style>
<script>
	n=1;
	function addTime(cng) {
		num1="";
		num2="";
		val="";
		if(cng=="all"){
			console.log("addTime all");
			num1 = document.getElementById("all_add_time_1").value;
			num2 = document.getElementById("all_add_time_2").value;
			addTm = document.getElementById("all_addTm");
		} else if(cng=="one"){
			console.log("addTime one");
			num1 = document.getElementById("one_add_time_1").value;
			num2 = document.getElementById("one_add_time_2").value;
			addTm = document.getElementById("one_addTm");
		}
		
		if( num1 > 24 || num1 < 0 || num2 >60 || num2 < 0 ){
			alert("시간을 다시 입력해주세요");
		} else if( num1=='' || num2=='' ){
			alert("시간을 입력해주세요");
		} else {
			if( n > 5 ){
				alert("더 이상 추가할 수 없습니다");
			} else {
				val = num1 + ":" + num2;
				addTm.innerHTML = addTm.innerHTML + "<input type='button' name='rsvt_t"+(n++)+"' value='"+val
				+"'>최대 예약 가능 인원 : <input type='text' class='addbtn' name='rsvt_t"+(n++)+"_head_max' /> 명<br />";
// 				btnNum = n;
			}
		}
	}
</script>
<%
// 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List menuList = menudao.getMenu();
	MenuDTO mdtoo = new MenuDTO();
	
	int pageSize = 80;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage -1) * pageSize +1;
	int endRow = currentPage * pageSize;
	int count = 0;
	count = mgrsvtdao.getMgRsvtDateListCount();
	List mgrsvtList = null;
	if(count > 0){
		mgrsvtList = mgrsvtdao.getMgRsvtDateList(startRow, endRow);
	}
%>
<form action="mgRsvtSettingPro.jsp" method="post" >
	<!-- <table class="list_table">
		<tr class="cng_th">
			<th>
				<div class="formdiv" >
					<h3>일괄변경</h3>
					<label class="formdiv">예약 최대 인원 : </label><input type="number" name="mg_head_count_max" /> 명<br />
					예약 최소 인원 : <input type="number" name="mg_head_count_min" /> 명<br />
					예약금 : <input type="number" id="deposit" max="24" min="0" /> 원
				</div>
			</th>
			<th>
				<div class="formdiv" >
					<div id="all_addTm">
						예약 시간 1 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" /><br />
						예약 시간 2 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" /><br />
						예약 시간 3 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" /><br />
						예약 시간 4 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" /><br />
						예약 시간 5 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" /><br />
					</div>
				</div>
			</th>

				<div class="formdiv" >
					<h3>일괄변경</h3>
					<label class="formdiv">예약 최대 인원 : </label><input type="number" name="mg_head_count_max" /> 명<br />
					예약 최소 인원 : <input type="number" name="mg_head_count_min" /> 명<br />
					<div id="all_addTm">
						예약 시간 추가 : <input type="number" id="all_add_time_1" max="24" min="0" />
									: <input type="number" id="all_add_time_2" max="60" min="0" />
									<input type="button" value="추가하기" onclick="addTime('all');"/><br />
					</div>
					예약금 : <input type="number" id="deposit" max="24" min="0" />
					<input type="submit" value="저장" onclick="" />
				</div>
			</th>
			<th width="100"></th>
			<th>
				<div class="formdiv" >
					<h3>일별변경</h3>
					예약 불가일 설정 : <input type="date" name="mng_openclose" /><br />
					예약가능상태 : 영업일<input type="radio" name="rsvt_psblty_n" value="Y" />
								휴무일<input type="radio" name="rsvt_psblty_n" value="N" /><br />
					<div id="one_addTm">
						예약 시간 추가 : <input type="number" id="one_add_time_1" max="24" min="0" />
									: <input type="number" id="one_add_time_2" max="60" min="0" />
									<input type="button" value="추가하기" onclick="addTime('one');"/><br />
					</div>
					<input type="submit" value="저장" onclick="" />
				</div>
			</th>
		</tr>
		<tr>
			
			<td colspan="3">
				예약 가능 메뉴
				<select name="chsmenu">
					<%
						for(int i = 0; i < menuList.size(); i++) {
							mdtoo = (MenuDTO)menuList.get(i);
							%><option><%=mdtoo.getName() %></option><%
						}
					%>
				</select>
			</td>
		</tr>
		<tr class="list_table"><input type="submit" value="수정" onclick="" /></tr>
	</table>
 -->
</form>
	<div style="clear: left;"></div>
<%if(count == 0){%>
	<table class="list_table" border="1">
		<tr>
			<td>예약 내역이 없습니다</td>
		</tr>
	</table>
<%}else {%>
	<table class="list_table" border="1">
		<tr align="center">
			<th width="100">일자</td>
			<th width="100">영업상태</td>
<!-- 			<th width="100">예약최대인원</td> -->
<!-- 			<th width="100">예약최소인원</td> -->
			<th width="300">내용</td>
			<th width="100">예약금</td>
			<th width="100">예약시간1</td>
			<th width="100">예약최대인원</td>
			<th width="100">예약시간2</td>
			<th width="100">예약최대인원</td>
			<th width="100">예약시간3</td>
			<th width="100">예약최대인원</td>
			<th width="100">예약시간4</td>
			<th width="100">예약최대인원</td>
			<th width="100">예약시간5</td>
			<th width="100">예약최대인원</td>
		</tr>
<%
		String psblty_yn = "";
		for(int i = 0; i < mgrsvtList.size(); i++){
			mgrsvtdto = (MgRsvtDTO)mgrsvtList.get(i);
%>
			<tr>
				<td><a href="mgRsvtSelectDay.jsp?date=<%=mgrsvtdto.getDate_value().substring(0, 10) %>"><%=mgrsvtdto.getDate_value().substring(0, 10) %></a></td>
<%
				if(mgrsvtdto.getRsvt_psblty_yn().equals("Y")){
					psblty_yn = "정상영업";
				} else if(mgrsvtdto.getRsvt_psblty_yn().equals("N")){
					psblty_yn = "휴무";
				}
// 486597
%>
				<td><%=psblty_yn %></td>
<%-- 				<td><%=mgrsvtdto.getMg_head_count_max() %></td> --%>
<%-- 				<td><%=mgrsvtdto.getMg_head_count_min() %></td> --%>
<%
				String exp = mgrsvtdto.getExplain();
				if(exp == null || exp.equals("null")){
					exp = " - ";
				}
				String t1 = mgrsvtdto.getRsvt_t1();
				if(t1 == null || t1.equals("null")){
					t1 = " - ";
				}
				String t2 = mgrsvtdto.getRsvt_t2();
				if(t2 == null || t2.equals("null")){
					t2 = " - ";
				}
				String t3 = mgrsvtdto.getRsvt_t3();
				if(t3 == null || t3.equals("null")){
					t3 = " - ";
				}
				String t4 = mgrsvtdto.getRsvt_t4();
				if(t4 == null || t4.equals("null")){
					t4 = " - ";
				}
				String t5 = mgrsvtdto.getRsvt_t5();
				if(t5 == null || t5.equals("null")){
					t5 = " - ";
				}
%>
				<td><%=exp								%></td>
				<td><%=mgrsvtdto.getDeposit()			%></td>
				<td><%=t1								%></td>
				<td><%=mgrsvtdto.getRsvt_t1_head_max()	%></td>
				<td><%=t2								%></td>
				<td><%=mgrsvtdto.getRsvt_t2_head_max()	%></td>
				<td><%=t3								%></td>
				<td><%=mgrsvtdto.getRsvt_t3_head_max()	%></td>
				<td><%=t4								%></td>
				<td><%=mgrsvtdto.getRsvt_t4_head_max()	%></td>
				<td><%=t5								%></td>
				<td><%=mgrsvtdto.getRsvt_t5_head_max()	%></td>
			</tr>
		<%}%>
	</table>
<%}%>
<table class="list_table">
	<tr>
		<td>
			<%
				// 페이징처리
				if(count > 0 ){
					int pageCount = count / pageSize + (count % pageSize == 0?0:1);
					int startPage = (currentPage/10) * 10 + 1;
					int pageBlock = 10;
					int endPage = startPage + pageBlock -1;
					
					if(endPage > pageCount) {
						endPage = pageCount;
					}
					if(startPage > 10){
						%><a href="mgRsvtSetting.jsp?pageNum=<%=startPage-10%>">[이전]</a><%
					}
					for(int i = startPage; i<= endPage; i++){
						%><a href="mgRsvtSetting.jsp?pageNum=<%=i%>">[<%=i%>]</a><%
					}
					if(endPage < pageCount){
						%><a href="mgRsvtSetting.jsp?pageNum=<%=startPage+10%>">[다음]</a><%
					}
				} 
			%>
		</td>
	</tr>
</table>
