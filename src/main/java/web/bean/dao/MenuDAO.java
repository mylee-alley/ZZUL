package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import web.bean.dto.MenuDTO;

public class MenuDAO {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   private String sql = null;
   
   public void menuInput(MenuDTO dto) {
      try {
         conn = OracleConnection.getConnection();
         sql = "insert into menu(num, name, detail, price) values(menu_seq.nextVal, ?, ?, ?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getName());
         pstmt.setString(2, dto.getDetail());
         pstmt.setString(3, dto.getPrice());
         pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
   }
   
   public List getMenu(){
      List menuList = null;
      try {
         conn = OracleConnection.getConnection();
         sql = "select * from menu where onoff=0 or onoff=1";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         menuList = new ArrayList();
         while(rs.next()) {
            MenuDTO dto = new MenuDTO();
            dto.setNum(rs.getInt("num"));
            dto.setName(rs.getString("name"));
            dto.setDetail(rs.getString("detail"));
            dto.setPrice(rs.getString("price"));
            dto.setCount(rs.getInt("count"));
            dto.setOnoff(rs.getInt("onoff"));
            dto.setImg(rs.getString("img"));
            menuList.add(dto);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
      return menuList;
   }
   
   public MenuDTO getMenuDetail(int num) {
      MenuDTO dto = null;
      try {
         conn = OracleConnection.getConnection();
         sql = "select * from menu where num=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto = new MenuDTO();
            dto.setNum(rs.getInt("num"));
            dto.setName(rs.getString("name"));
            dto.setDetail(rs.getString("detail"));
            dto.setPrice(rs.getString("price"));
            dto.setCount(rs.getInt("count"));
            dto.setOnoff(rs.getInt("onoff"));
            dto.setImg(rs.getString("img"));
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
      return dto;
   }
   
   public void menuUpdate(MenuDTO dto) {
         try {
            conn = OracleConnection.getConnection(); // db 연결
            sql= "update menu set name=? , detail=? ,price=?,onoff=? where num=?" ;   // 테이블에 이름 설명 가격 판매여부 를 입력받아 저장하고 조건을 걸어서 
            pstmt = conn.prepareStatement(sql);                              // num 과 일치해야 업데이트가 되게끔 함
            pstmt.setString(1, dto.getName());   // 입력 받은 값을 db에 저장한다
            pstmt.setString(2, dto.getDetail());
            pstmt.setString(3, dto.getPrice());
            pstmt.setInt(4, dto.getOnoff());
            pstmt.setInt(5, dto.getNum());
            pstmt.executeUpdate();   //업데이트 실행
            
         } catch (Exception e) {
            e.printStackTrace();
         }finally {
            OracleConnection.close(rs, pstmt, conn);
         }
      }
   
   //삭제버튼 클릭시 DB에는 남아있도록 onoff컬럼 2로 업데이트(0판매중지_1판매중_2삭제)
   public int menuDelete(int num) {
	   	int result = 0 ;
         try {
            conn = OracleConnection.getConnection();
            sql= "update menu set onoff=2 where num=?" ; 
            pstmt = conn.prepareStatement(sql);                            
            pstmt.setInt(1, num);            
            result = pstmt.executeUpdate(); //1 행 이(가) 업데이트되었습니다.     
         } catch (Exception e) {
            e.printStackTrace();
         }finally {
            OracleConnection.close(rs, pstmt, conn);
         } return result;
      }
   
   public void imgChange(String img, int num) {
      try {
         conn = OracleConnection.getConnection();
         sql = "update menu set img=? where num=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, img);
         pstmt.setInt(2, num);
         pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
   }
}