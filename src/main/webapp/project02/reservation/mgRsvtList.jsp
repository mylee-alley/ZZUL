<%@page import="web.bean.dto.MenuDTO"%>
<%@page import="web.bean.dao.MenuDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.bean.dto.ReservationDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.bean.dao.MgRsvtDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" flush="true"/>
<jsp:useBean id="dao" class="web.bean.dao.MgRsvtDAO"></jsp:useBean>
<jsp:useBean id="menudao" class="web.bean.dao.MenuDAO"></jsp:useBean>
<jsp:useBean id="menudto" class="web.bean.dto.MenuDTO"></jsp:useBean>
<jsp:useBean id="rsvtdto" class="web.bean.dto.ReservationDTO"></jsp:useBean>
<jsp:useBean id="rsvtdao" class="web.bean.dao.ReservationDAO"></jsp:useBean>
<style>
	table { margin-left:auto; margin-right:auto; }
	span { margin-left:auto; margin-right:auto; }
	td { text-align: center; }
	a { text-decoration-line: none; }
</style>
<script>
	function rsvtCancle(vdate,name,menu,hcount,rsvtid){
		alert("정말 삭제하시겠습니까?");
		console.log("얌마아" + rsvtid);
		window.open("bkCanclePopup.jsp?&vdate="+vdate+
 				"&name="+name+
 				"&menu="+menu+
 				"&hcount="+hcount+
 				"&rid="+rsvtid , "_blank", "width=400, height=600");
	}
</script>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	int pageSize = 20;
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage -1) * pageSize +1;
	int endRow = currentPage * pageSize;
	int count = 0;
	String divis = "all";
	if(divis != null){
		divis = request.getParameter("divis");
	}
	count = dao.getRsvtListCount(divis);
	List rsvtList = null;
	if(count >= 0) {
		rsvtList = dao.getRsvtList(startRow, endRow, divis);
	}
%>
<table>
	<tr>
		<td>
			전체 <input type="radio" name="orderby" value="전체" checked="checked" />
			예약취소제외 <input type="radio" name="orderby" value="예약취소제외" />
			<input type="radio" name="orderby" value="예약일" />
			<input type="radio" name="orderby" value="예약일" />
			예약건수 : <%=count%>
		</td>
	</tr>
</table>
<!-- <form action="mgRsvtListSelect.jsp" method="get"> -->
<% if (count == 0) { %>
	<table border="1">
		<tr height="30">
			<td width="150" > 방문일자 </td>
			<td width="100" > 예약자명 </td>
			<td width="150" > 전화번호 </td>
			<td width="450" > 주문메뉴 </td>
			<td width="80"	> 인원수  </td>
			<td width="80"	> 예약금 </td>
			<td width="80"	> 결제방식 </td>
			<td width="200" > 예약결제일자 </td>
			<td width="100" > 예약취소상태 </td>
			<td width=""	> 예약취소 </td>
			<td width="100" > 가입여부 </td>
		</tr>
		<tr>
			<td colspan="11">예약 내역이 없습니다.</td>
		</tr>
	</table>
<%} else { %>
	<table border="1">
		<tr height="30">
			<td width="150" > 방문일자 </td>
			<td width="100" > 예약자명 </td>
			<td width="150" > 전화번호 </td>
			<td width="450" > 주문메뉴 </td>
			<td width="80"	> 인원수  </td>
			<td width="80"	> 예약금 </td>
			<td width="80"	> 결제방식 </td>
			<td width="200" > 예약결제일자 </td>
			<td width="100" > 예약취소상태 </td>
<%
			if(!divis.equals("cancel")){
				%><td width=""	> 예약취소 </td><%
			}
%>
			<td width="100" > 가입여부 </td>
		</tr>
<% 
		String menu="";
		String payw="";
		String stt="";
		String joinId="";
		List userRsvtMenu = null;
		ReservationDTO rdto = new ReservationDTO();
		for (int i = 0 ; i < rsvtList.size(); i++){
			rsvtdto = (ReservationDTO)rsvtList.get(i);
%>
		<input type="hidden" name="rsvt_id" value=<%=rsvtdto.getRsvt_id() %> />
		<tr height="30">
			<td width="" ><%=sdf.format(rsvtdto.getVisit_date())%></td>
			<td width="" ><a href="mgRsvtListSelect.jsp?rsvt_id=<%=rsvtdto.getRsvt_id()%>" value="<%=rsvtdto.getRsvt_name()%>"  ><%=rsvtdto.getRsvt_name()%></a></td>
			<td width="" ><%=rsvtdto.getRsvt_phon()%></td>
			<td width="" >
<%
// 			int menuNum = Integer.parseInt(rsvtdto.getRsvt_menu());
// 			menudto = menudao.getMenuDetail(menuNum);
// 			menu = menudto.getName();
			userRsvtMenu = rsvtdao.getMenuList(rsvtdto.getRsvt_id());
// 			rdto = (ReservationDTO)userRsvtMenu.get(i);
			for(int j = 0; j < userRsvtMenu.size(); j++){
// 				System.out.println("mgRsvtList.jsp userRsvtMenu.get(j) ::: " + userRsvtMenu.get(j));
				%><%=userRsvtMenu.get(j)%> <br /><%
			}
%>
<%-- 			<td width="" ><%=rsvtdto.getRsvt_menu()%></td> --%>
			</td>
			<td width="" ><%=rsvtdto.getRsvt_head_count()%>명</td>
			<td width="" ><%=rsvtdto.getDeposit()%></td>
<%
			if(rsvtdto.getDeposit_payby() == 1) {
				payw = "카드결제";
			} else if (rsvtdto.getDeposit_payby() == 2) {
				payw = "계좌이체";
			} else if (rsvtdto.getDeposit_payby() == 3) {
				payw = "간편결제";
			}
%>
			<td width="" ><%=payw%></td>
			<td width="" ><%=sdf2.format(rsvtdto.getRsvt_date())%></td>
<%
			if(rsvtdto.getRsvt_status() == 1) {
				stt = "예약";
			} else {
				stt = "예약취소";
			}
%>
			<td width="" ><%=stt%></td>
			<input type="hidden" name="rsvt_status" value="<%=rsvtdto.getRsvt_status() %>" />
<!-- </form> -->
<form action="bkCanclePopup.jsp" method="post">
	<input type="hidden" name="getRsvt_id" value="<%=rsvtdto.getRsvt_id()%>" />
	<input type="hidden" name="visit_date" value="<%=rsvtdto.getVisit_date()%>" />
	<input type="hidden" name="rsvt_name" value="<%=rsvtdto.getRsvt_name()%>" />
	<input type="hidden" name="menu[]" value="<%=userRsvtMenu%>" />
	<input type="hidden" name="rsvt_head_count" value="<%=rsvtdto.getRsvt_head_count()%>" />
<%
			if(!divis.equals("cancel")){
				if(rsvtdto.getRsvt_status() == 1) {
					%><td width="" ><input type="submit" value="예약취소" /></td><%
				} else {
					%><td width="" ></td><%
				}
			}
%>
<%
			if(rsvtdto.getUser_id() != null ) {
				joinId = "회원";
			} else {
				joinId = "비회원";
			}
%>
			<td width="" ><%=joinId%></td>
		</tr>
		<%} %>
	</table>
	<%} %>
</form>
	<table>
		<tr>
			<td>
<%
					// 페이징처리
					if(count > 0){
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1 );
						int startPage = (currentPage/10) * 10 + 1;
						int pageBlock = 10;
						int endPage = startPage + pageBlock -1;
						
						if(endPage > pageCount) {
							endPage = pageCount;
						}
						if(startPage > 10){
							%><a href="mgRsvtList.jsp?pageNum=<%=startPage-10 %>">[이전]</a><%
						}
						for(int i = startPage; i <= endPage; i++){
							%><a href="mgRsvtList.jsp?pageNum=<%=i %>&divis=<%=divis%>">[<%=i%>]</a><%
						}
						if(endPage < pageCount){
							%><a href="mgRsvtList.jsp?pageNum=<%=startPage+10 %>">[다음]</a><%
						}
					}
%>
			</td>
		</tr>
	</table>
