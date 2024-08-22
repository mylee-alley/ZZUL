package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.Catch;

import web.bean.dto.MenuDTO;
import web.bean.dto.ReservationDTO;
import web.bean.dto.RsvtMenuDTO;

public class SalesDAO {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   private String sql = null;
   
   
   
   public int getMenuSales(RsvtMenuDTO rsmdto ) { //map으로 합산해서넣어줌
      int result = 0;
      try {
         conn = OracleConnection.getConnection();
         sql = "select price from menu where name = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, rsmdto.getMenu());
         rs= pstmt.executeQuery();
         if(rs.next()) {
            result = (Integer.parseInt(rs.getString("price")))*rsmdto.getCount();
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
      return result;
   }
   
   public List getRsvtMenu(ReservationDTO dto) {
      RsvtMenuDTO rsvtmenu = null;
      List rsvtList = new ArrayList<>();
      try {
         conn = OracleConnection.getConnection();
         sql = "select *  from rsvt_menu where rsvt_id = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getRsvt_id());
         rs= pstmt.executeQuery();
         while(rs.next()) {
            rsvtmenu = new RsvtMenuDTO();
            rsvtmenu.setMenu(rs.getString("menu"));
            rsvtmenu.setCount(rs.getInt("count"));
            rsvtList.add(rsvtmenu);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
      return rsvtList;
   }

   public static LocalDateTime parseDate(String dateString) {
        DateTimeFormatter format;
        if(dateString.contains(":")) {
           // 2022-10-31 21:00 이라는 문자열은 여기 걸립니다.
            format = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            return LocalDateTime.parse(dateString, format);
        }
        
      // 2022-12-02 라는 문자열은 여기 걸립니다.
        format = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return LocalDate.parse(dateString, format).atStartOfDay();
    }
   
   public static class ReservationDTOComparator implements Comparator<ReservationDTO> {
        @Override
        public int compare(ReservationDTO dto1, ReservationDTO dto2) {
            // 날짜를 문자열로 비교하여 오름차순으로 정렬
            return dto1.getVisit_date().compareTo(dto2.getVisit_date());
        }
    }
   
   public List<ReservationDTO> getDefosit() {
         ReservationDTO rdto=null;
         List<ReservationDTO> list = null;
         list = new ArrayList<>();
         try {
            conn = OracleConnection.getConnection();
            sql = "select * from reservation where rsvt_status = 1";
            pstmt = conn.prepareStatement(sql);
            rs= pstmt.executeQuery();
            while(rs.next()) {
               rdto= new ReservationDTO();
               rdto.setRsvt_id(rs.getString("rsvt_id"));
               rdto.setRsvt_name(rs.getString("rsvt_name"));
               rdto.setRsvt_menu(rs.getString("rsvt_menu"));
               rdto.setDeposit(rs.getString("deposit"));
               rdto.setRsvt_date(rs.getTimestamp("rsvt_date"));
               rdto.setRsvt_head_count(rs.getInt("rsvt_head_count"));
               rdto.setVisit_date(rs.getTimestamp("visit_date"));
               rdto.setRsvt_status(rs.getInt("rsvt_status"));
               list.add(rdto);
            }
            }catch (Exception e) {
               e.printStackTrace();
            }finally {
               OracleConnection.close(rs, pstmt, conn);
            }
         
         return list;
   }
}
