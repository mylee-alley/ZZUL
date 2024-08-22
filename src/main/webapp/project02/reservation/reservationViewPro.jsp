<%@page import="java.sql.Timestamp"%>
<%@page import="web.bean.dto.RsvtMenuDTO"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.bean.dao.MenuDAO"%>
<%@page import="web.bean.dto.MemberDTO"%>
<%@page import="web.bean.dto.ReservationDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   

<jsp:useBean id="dto" class="web.bean.dto.ReservationDTO"/>
<jsp:useBean id="dao" class="web.bean.dao.ReservationDAO"/>
    
<%
    request.setCharacterEncoding("UTF-8");
       

       int count=0;
       String name = request.getParameter("name");                  //reservationView.jsp부터 name받아오기
       String phon = request.getParameter("phon");                  //reservationView.jsp부터 phon받아오기
       String dphon = phon.replace("-","");                     //reservationView.jsp에서 받아온 phon -를 바꿔서 데이터베이스에 저장된 형식맞추기
       List<ReservationDTO> list = dao.getReservationView(name, dphon);//ReservationDAO에서 dto정보를 리스트에저장
       List<RsvtMenuDTO> rmlist = null;                        //메뉴의 이름과 주문수의 가격 받기위한 리스트선언
       ReservationDTO rdto = null;                              //예약자정보를 받기위한 리스트선언
       RsvtMenuDTO rmdto = null;                              //메뉴의 주문수를 받기위한 리스트선언
       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
       SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");//날자데이터형식 포멧
       LocalDate nowDate = LocalDate.now();                     //현재시간받아오기
       String menuname = "";                                 //메뉴이름을 넣기위한 스트링변수선언
       int index = 0;
       if(list !=null){                                    //예약자정보가 있을때만출력
          for(int i = 0 ; i < list.size();i++){                  //리스트의정보만큼만큼 반복
       rdto = (ReservationDTO)list.get(i);                  //리스트에 저장된 rdto의정보를 set
       rmlist = dao.getMenu(rdto);                        //예약자의 아이디를 보내주어 그 아이디를 where로사용
       LocalDate visitDate = rdto.getVisit_date().toLocalDateTime().toLocalDate();//예약시간과 현재시간을 비교하기위해 형식 맞춰주기 timestemp > localdate > localdateTime
       int menuNum = Integer.parseInt(rdto.getRsvt_menu());   //메뉴수를 인트로변환
       List<String> menuList = dao.getMenuList(rdto.getRsvt_id());//메뉴리스트를 아이디기준으로 저장
    %>         
         <table border="1">
            <tr>
               <td>주문번호</td>
               <td><%=rdto.getRsvt_id()%></td>
            </tr>
            <tr>
               <td>예약자명</td>
               <td><%=rdto.getRsvt_name()%></td>
            </tr>
            <tr>
               <td>메뉴</td>
               <td><%
               for(RsvtMenuDTO menu : rmlist){         //예약한 메뉴를 전부출력
                           menuname = menu.getMenu();
               %><%=menuname%><br>
                  <%
                  }
                  %></td>
            </tr>
            <tr>
               <td>수량</td>
               <td>
<%
               for(RsvtMenuDTO menu : rmlist){         //예약한 메뉴의 수량을출력
%>                     <%=menu.getCount() %><br>
<%                  } 
%>               </td>
            </tr>
            <tr>
               <td>예약하신날</td>
               <td><%=sdf.format(rdto.getRsvt_date())%></td>
            </tr>
            <tr>
               <td>인원수</td>
               <td><%=rdto.getRsvt_head_count() %></td>
            </tr>
            <tr>
               <td>방문날짜</td>
               <td><%=sdf1.format(rdto.getVisit_date())%> <%=rdto.getVisit_time() %></td>
            </tr>
            <tr>
<%                  if (rdto.getRsvt_status() == 0) {
                        String stt = "예약취소 완료";
%>
                       <td><%=stt%></td>
<%
                    } else if (rdto.getRsvt_status() == 1) {
                       String stt = "예약";
%>
                  <td colspan="2" width=""><%=stt%>
                           <form action="bkCanclePopup.jsp" onclick="_blank" method="post" style="display: inline;">
                            <input type="hidden" name="getRsvt_id" value="<%=rdto.getRsvt_id()%>" />
                            <input type="hidden" name="visit_date" value="<%=rdto.getVisit_date()%>" />
                            <input type="hidden" name="visit_time" value="<%=rdto.getVisit_time() %>"/>
                            <input type="hidden" name="rsvt_name" value="<%=rdto.getRsvt_name()%>" />
                            <input type="hidden" name="menu[]" value="<%=menuList%>" />
                            <input type="hidden" name="rsvt_head_count" value="<%=rdto.getRsvt_head_count()%>" />
<%
                            LocalDateTime localDateTime = LocalDateTime.now();
                            Timestamp timestamp = Timestamp.valueOf(localDateTime);
                            Timestamp anotherTimestamp = rdto.getVisit_date();
                            if (timestamp.before(anotherTimestamp)) {
%>
                                 <input type="submit" value="예약 취소하기" />
<%
                              }else if (timestamp.after(anotherTimestamp)) {
%>

<%
                              }
%>                     </form>
                  </td>
<%            }   //else if (rdto.getRsvt_status() == 1) 종료 

%>
            <tr>
               <td>리뷰 작성</td>
               <td>
                 <form action="/project/project02/review/writeForm.jsp" method="post">
<%
                  for (RsvtMenuDTO menu : rmlist){
                     menuname = menu.getMenu();
%>                     <input type="hidden" name="menu[]" value="<%=menuname%>">
<%                  }
%>                  <input type="hidden" name="rsvt_id" value="<%=rdto.getRsvt_id()%>"> 
<%
                  LocalDateTime localDateTime1 = LocalDateTime.now();
                  Timestamp timestamp1 = Timestamp.valueOf(localDateTime1);
                  Timestamp anotherTimestamp1 = rdto.getVisit_date();
                  if(rdto.getReview()==0){
                     if(timestamp1.after(anotherTimestamp1)){
%>                        <input type="submit" value="리뷰작성" />   
<%                     }else{
%>                        작성 기간이 아닙니다.
<%                     }
                  }else{
%>                          작성 완료
<%                  }
%>
                       </form>
               </td>
            </tr>
         </table>
<%   
      }         //for(int i = 0 ; i < list.size();i++){ 종료
   }            //if(list !=null) 종료
%>
         <a href="#" onClick="history.back()">돌아가기</a>

<%      if(count == 0){  // 원랜 count<변수에 세션에 저장된아이디가있으면 count가 1로 설정되게 해둿지만 따로 예약페이지가있어서 미구현%> 
         <a href="/project/project02/user/login.jsp">로그인</a>
         <a href="/project/project02/user/input.jsp">회원가입</a>
         
<%      }
%>