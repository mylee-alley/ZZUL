<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dao" class="web.bean.dao.MgRsvtDAO" />
<jsp:useBean id="dto" class="web.bean.dto.MgRsvtDTO" />
<%
	dto.setDate_value(request.getParameter("date_value"));
	dto.setRsvt_psblty_yn(request.getParameter("rsvt_psblty_yn"));
	dto.setMg_head_count_max(Integer.parseInt(request.getParameter("mg_head_count_max")));
	dto.setMg_head_count_min(Integer.parseInt(request.getParameter("mg_head_count_min")));

	if(request.getParameter("rsvt_psblty_yn").equals("N")){
		dto.setRsvt_t1("");
		dto.setRsvt_t1_head_max(0);
		dto.setRsvt_t2("");
		dto.setRsvt_t2_head_max(0);
		dto.setRsvt_t3("");
		dto.setRsvt_t3_head_max(0);
		dto.setRsvt_t4("");
		dto.setRsvt_t4_head_max(0);
		dto.setRsvt_t5("");
		dto.setRsvt_t5_head_max(0);
		dto.setDeposit("");
		dto.setExplain(request.getParameter("explain"));
	} else {
		dto.setRsvt_t1(request.getParameter("rsvt_t1"));
		dto.setRsvt_t1_head_max(Integer.parseInt(request.getParameter("rsvt_t1_head_max")));
		dto.setRsvt_t2(request.getParameter("rsvt_t2"));
		dto.setRsvt_t2_head_max(Integer.parseInt(request.getParameter("rsvt_t2_head_max")));
		dto.setRsvt_t3(request.getParameter("rsvt_t3"));
		dto.setRsvt_t3_head_max(Integer.parseInt(request.getParameter("rsvt_t3_head_max")));
		dto.setRsvt_t4(request.getParameter("rsvt_t4"));
		dto.setRsvt_t4_head_max(Integer.parseInt(request.getParameter("rsvt_t4_head_max")));
		dto.setRsvt_t5(request.getParameter("rsvt_t5"));
		dto.setRsvt_t5_head_max(Integer.parseInt(request.getParameter("rsvt_t5_head_max")));
		dto.setDeposit(request.getParameter("deposit"));
	}
	
// 	String strti = "rsvt_t";
// 	String strihm= "_head_max";
// 	for(int i=0; i<5; i++){
// 		strti = "rsvt_t" + i;
// 		strihm= strti + "_head_max";
// 		if(request.getParameter(strti).equals("-")){
			
// 		} else {
// 			request.getParameter(strihm);
// 		}
		
// 	}
	
	
	
	dao.updateMgRsvtDate(dto);
%>
<script>
	alert("수정되었습니다.");
	window.location="mgRsvtSetting.jsp";
</script>











