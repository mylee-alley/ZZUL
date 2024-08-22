<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.ReservationDTO" />
<jsp:useBean id="dao" class="web.bean.dao.ReservationDAO" />
<jsp:useBean id="mgdao" class="web.bean.dao.MgRsvtDAO" />
<jsp:useBean id="mgdto" class="web.bean.dto.MgRsvtDTO" />
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%
	String dvsn = request.getParameter("dvsn");
	String vstime ="";		// 방문시간 파라미터 담을 변수
	String astr="";			// alert창 메시지 내용 담을 변수
	String rsvtTimeNum="";	// 방문시간
	dto.setVisit_time(request.getParameter("visit_time"));
	
	// reserveForm.jsp 예약일자 option 선택시 - 선택된 일자의 예약가능 상태, 시간, 인원수 등 조회
	if(dvsn.equals("time")){
		vstime = dto.getVisit_time();
		mgdto = mgdao.getRsvtDay(dto.getVisit_time());
		System.out.println("reservePro.jsp time rsvtTimeNum ::: " + request.getParameter("rsvtTimeNum"));
		rsvtTimeNum = request.getParameter("rsvtTimeNum");
// 		dao.checkOverHead(date, time);
		
	// reserveForm.jsp 예약하기 버튼 클릭시 - 예약
	} else if(dvsn.equals("reserve")){
		System.out.println("reservePro.jsp rsvt_name ::: " + request.getParameter("rsvt_name"));
		System.out.println("reservePro.jsp rsvt_name ::: " + request.getParameter("rsvt_name").length());
// 		String chkVT = "";
// 		String chkRN = "";
// 		String chkRP = "";
// 		String chkRHC = "";
		// 유효성 체크
		if(request.getParameter("visit_time") == null){
			dvsn = "check";
			astr = "방문 시간을 선택해주세요";
		} else if(request.getParameter("rsvt_name") == null || request.getParameter("rsvt_name") == ""
				|| request.getParameter("rsvt_name").length() < 3 || request.getParameter("rsvt_name").length() > 10){//3~10이하
			System.out.println("dddddddddddddddddddddddddddrsvt_name ::: " + request.getParameter("rsvt_name"));
			System.out.println("ddddddddddddddddddddddddddd.length() ::: " + request.getParameter("rsvt_name").length());
			dvsn = "check";
			astr = "이름을 다시 입력해주세요 (3자 이상 10자 이하)";
		} else if(request.getParameter("rsvt_phon") == null || request.getParameter("rsvt_phon") == ""){//9~11이하
			dvsn = "check";
			astr = "전화번호를 다시 입력해주세요 (9자 이상 11자 이하)";
		} else if(request.getParameter("rsvt_head_count") == null || request.getParameter("rsvt_head_count") == ""){
			dvsn = "check";
			astr = "인원을 선택해주세요";
		} else {
		
			String visitDateStr = request.getParameter("visit_date");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date parseDate = sdf.parse(visitDateStr);
			Timestamp visit_date = new Timestamp(parseDate.getTime());
			
			// reserveForm.jsp 메뉴체크박스 중 체크된 메뉴 번호와 이름 수량을 배열로 받아 menu에 대입
			// ex) 1번 3번 체크시 -> 1-1번 메뉴  ,  3-A코스(소...
			String [] menu = request.getParameterValues("select_menu");
			
			dto.setRsvt_name(request.getParameter("rsvt_name"));
			dto.setRsvt_phon(request.getParameter("rsvt_phon"));
			
			int overHead = 0;
			// 체크된 메뉴가 없을때
			if(menu == null){
				dvsn = "check";
				astr = "주문하실 메뉴를 체크해주세요";
			} else {
				// 선택한 일자와 시간의 최대 예약 가능 인원수
	// 			int timeheadLimit = Integer.parseInt(request.getParameter("overhd"));
				
				// 예약현황에 따른 잔여 예약 가능 인원수
	// 			overHead = dao.checkOverHead(request.getParameter("visit_date"), request.getParameter("visit_time"));
				
	// 			if(timeheadLimit - overHead == 0){
	// 				dvsn = "check";
	// 				astr = "예약이 마감되었습니다";
	// 			} else if(timeheadLimit - overHead < Integer.parseInt(request.getParameter("rsvt_head_count"))){
	// 				dvsn = "check";
	// 				astr = "인원을 다시 선택해주세요 예약가능최대인원은 " + overHead + "명입니다";
					
	// 			}else {
				dvsn = "";
				astr = "예약이 완료되었습니다.";
				dto.setRsvt_menu(Integer.toString(menu.length));	// 체크된 메뉴의 갯수
				dto.setDeposit(request.getParameter("deposit"));
				dto.setRsvt_head_count(Integer.parseInt(request.getParameter("rsvt_head_count")));
				dto.setVisit_date(visit_date);						// 위에서 Timestamp로 변환한 방문일자
				dto.setUser_id((String)session.getAttribute("sid"));
				dto.setVisit_time(request.getParameter("visit_time"));
				
				dao.userBooking(dto);
				System.out.println("reservePro.jsp userBooking ㅇ얼니어미나ㅓㅇ리ㅓㅁㄴ이라ㅓ미ㅏㄴ어리ㅏ먼이럼니아ㅓ");
				String rid = dao.getRsvtId(dto.getRsvt_name(), dto.getRsvt_phon(), visit_date);
				dto.setRsvt_id(rid);
				
					
				for(String m : menu){ //ex) 1-1번 메뉴 -> select_menu_count_1과 1번 메뉴로 분리됨]
					System.out.println("얌마아아아아아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ" + request.getParameter("select_menu_count_"+m.split("-")[0]));
					if(request.getParameter("select_menu_count_"+m.split("-")[0]) != null || request.getParameter("select_menu_count_"+m.split("-")[0]) != ""){
						dto.setCount(Integer.parseInt(request.getParameter("select_menu_count_"+m.split("-")[0])));
						dto.setMenu(m.split("-")[1]);
						
						dao.updateRsvtMenu(dto);
						System.out.println("reservePro.jsp for(String m : menu) " + dto.toString());
					} else {
						dvsn = "check";
						astr = "체크된 메뉴의 수량을 입력해주세요";
					}
				}
	// 			}
				
			}
		}
	}
%>
<script>
	var timeorbook = "<%=dvsn%>";
	if(timeorbook == "time"){
		window.location="/project/project02/reservation/reserveForm.jsp?visit_date=<%=vstime%>"
				+"&rsvt_t1=<%=mgdto.getRsvt_t1()%>"
				+"&rsvt_t2=<%=mgdto.getRsvt_t2()%>"
				+"&rsvt_t3=<%=mgdto.getRsvt_t3()%>"
				+"&rsvt_t4=<%=mgdto.getRsvt_t4()%>"
				+"&rsvt_t5=<%=mgdto.getRsvt_t5()%>"
				+"&rsvt_t1_head_max=<%=mgdto.getRsvt_t1_head_max()%>"
				+"&rsvt_t2_head_max=<%=mgdto.getRsvt_t2_head_max()%>"
				+"&rsvt_t3_head_max=<%=mgdto.getRsvt_t3_head_max()%>"
				+"&rsvt_t4_head_max=<%=mgdto.getRsvt_t4_head_max()%>"
				+"&rsvt_t5_head_max=<%=mgdto.getRsvt_t5_head_max()%>";
				+"&deposit=<%=mgdto.getDeposit()%>";
	} else if(timeorbook == "check") {
		alert('<%=astr%>');
		window.location="/project/project02/reservation/reserveForm.jsp";
	} else {
		alert('<%=astr%>');
		window.location="/project/project02/home.jsp";
	}
// 	window.close();
// 	window.opener.location.reload();
</script>