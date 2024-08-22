package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.MemberDTO;

public class MemberDAO {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   private String sql = null;
   
   public int memberInput(MemberDTO dto) {
	   int a = 0;
         try{
            conn = OracleConnection.getConnection();
            sql = "insert into member(id, pw, name, phone, email) values(?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getId());
            pstmt.setString(2, dto.getPw());
            pstmt.setString(3, dto.getName());
            pstmt.setString(4, dto.getPhone());
            pstmt.setString(5, dto.getEmail());
            a = pstmt.executeUpdate();
         } catch(Exception e) {
            e.printStackTrace();
         } finally {
            OracleConnection.close(rs, pstmt, conn);
         }
         return a;
      }
   
   public int memberlogin(MemberDTO dto) {
	   int result = 0;
	   int active = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select active, rownum r from member where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				active = rs.getInt("active");
				if (active == 0) {          // 활성화상태코드 0: 블랙리스트
					result = -1;
	            } else {
	               result = rs.getInt("r");   // 로그인 성공, 실패에 따른 값 대입
	            }
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         OracleConnection.close(rs, pstmt, conn);
	      }
	      return result;
	   }
   
   public int idCheck(String id) {
       int result = 0;
       try {
          conn = OracleConnection.getConnection(); 
           sql = "select count(*) from member where id=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, id);
          rs= pstmt.executeQuery();
          rs.next();
          result= rs.getInt(1);
       }catch(Exception e) {
          e.printStackTrace();
       }finally {
          OracleConnection.close(rs, pstmt, conn);
       }
       return result;
    }

   
   
   public int  memberDelete(String id , String pw) {
      int result = 0;
      try {
      conn=OracleConnection.getConnection();
      sql="delete from member where id=? and pw=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, id);
      pstmt.setString(2, pw);
      result = pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
      return result;
   }
   
   public MemberDTO member(String id) {
      MemberDTO dto=null;
      try {
         conn = OracleConnection.getConnection();
         sql = "select * from member where id=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         rs= pstmt.executeQuery();
         rs.next();
          dto = new MemberDTO();
           dto.setId(rs.getString("id"));
           dto.setPw(rs.getString("pw"));
           dto.setName(rs.getString("name"));
           dto.setPhone(rs.getString("phone"));
           dto.setEmail(rs.getString("email"));
           dto.setReg_date(rs.getTimestamp("reg_date"));
           dto.setBook_count(rs.getInt("book_count"));   
         
   } catch (Exception e) {
      e.printStackTrace();
   }finally {
      OracleConnection.close(rs, pstmt, conn);
   }
      return dto;
   
   }
   //정보수정
   public void memberUpdate(MemberDTO dto) {
      try {
        conn = OracleConnection.getConnection();
        sql = "update member set name=?, phone=?, email=? where id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dto.getName());
        pstmt.setString(2, dto.getPhone());
        pstmt.setString(3, dto.getEmail());
        pstmt.setString(4, dto.getId());
       
        pstmt.executeUpdate();  
	   } catch (Exception e) {
	      e.printStackTrace();
	   }finally {
	      OracleConnection.close(rs, pstmt, conn);
	   }
   }

   //비밀번호찾기아디
   public MemberDTO memberJoin(String name , String phone) {
      MemberDTO dto=null;
      try {
         conn = OracleConnection.getConnection();
         sql = "select * from member where name=? and phone=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, name);
         pstmt.setString(2, phone);
         rs= pstmt.executeQuery();
         rs.next();
         dto = new MemberDTO();
         dto.setId(rs.getString("id"));
         dto.setPw(rs.getString("pw"));

      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         OracleConnection.close(rs, pstmt, conn);
      }
         return dto;
      
      } 
   
	public void pwUpdate(MemberDTO dto) {
		try {
			conn = OracleConnection.getConnection();
			sql = "update member set pw=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getId());
			pstmt.executeUpdate();  
	   } catch (Exception e) {
	      e.printStackTrace();
	   }finally {
	      OracleConnection.close(rs, pstmt, conn);
	   }
	}
	
	public int updateMemberGrade(String memberId, int newGrade) { // 창희
		int result = 0;
		Connection conn = null;
	    PreparedStatement pstmt = null;
	    try {
	        conn = OracleConnection.getConnection();
	        pstmt = conn.prepareStatement("update member set USER_GRADE = ? where id = ?");
	        pstmt.setInt(1, newGrade);
	        pstmt.setString(2, memberId);
	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	        	OracleConnection.close(rs, pstmt, conn);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return result;
	}

	public List<MemberDTO> getAllMembers() {		//창희
	    List<MemberDTO> members = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = OracleConnection.getConnection();
	        pstmt = conn.prepareStatement("select * from MEMBER order by USER_GRADE desc");
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MemberDTO member = new MemberDTO();
	            member.setId(rs.getString("id"));
	            member.setName(rs.getString("name"));
	            member.setPhone(rs.getString("phone"));
	            member.setEmail(rs.getString("email"));
	            member.setBook_count(rs.getInt("book_count"));
	            member.setActive(rs.getInt("active"));
	            member.setUser_grade(rs.getInt("USER_GRADE"));
	            member.setReg_date(rs.getTimestamp("reg_date"));
	            members.add(member);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        	OracleConnection.close(rs, pstmt, conn);
	    }
	    return members;
	}
	
	public List<MemberDTO> getNewMembers() {		//창희
	    List<MemberDTO> members = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = OracleConnection.getConnection();
	        pstmt = conn.prepareStatement("select * from member where reg_date >= sysdate - interval '1' month order by reg_date desc");
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            MemberDTO member = new MemberDTO();
	            member.setId(rs.getString("id"));
	            member.setName(rs.getString("name"));
	            member.setPhone(rs.getString("phone"));
	            member.setEmail(rs.getString("email"));
	            member.setBook_count(rs.getInt("book_count"));
	            member.setActive(rs.getInt("active"));
	            member.setUser_grade(rs.getInt("USER_GRADE"));
	            member.setReg_date(rs.getTimestamp("reg_date"));
	            members.add(member);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	OracleConnection.close(rs, pstmt, conn);
	    }
	    return members;
	}
	
    public List<MemberDTO> searchMembers(String name) {
        List<MemberDTO> members = new ArrayList<>();     
        try {
            conn = OracleConnection.getConnection();
            String query = "select * from member where name like ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, "%" + name + "%"); // 입력한 이름이 포함된 회원을 검색
            rs = pstmt.executeQuery();
            while (rs.next()) {
                MemberDTO member = new MemberDTO();
                member.setId(rs.getString("id"));
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
                member.setBook_count(rs.getInt("book_count"));
                member.setActive(rs.getInt("active"));
                member.setUser_grade(rs.getInt("USER_GRADE"));
                members.add(member);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            OracleConnection.close(rs, pstmt, conn);
        }
        return members;
    }
}
