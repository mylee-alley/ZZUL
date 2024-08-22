package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.HelpBoardDTO;
import web.bean.dto.MemberDTO;

public class HelpBoardDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	
	public void insertArticle(HelpBoardDTO article) {
		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int status=article.getStatus();
		int number=0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select max(num) from helpboard");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number=rs.getInt(1)+1;	
			}else {
				number=1; 
			}
			
			if (num!=0) { 
				sql="update helpboard set re_step=re_step+1 where ref= ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
				status=status+1;
			}else{ 
				ref=number;
				re_step=0;
				re_level=0;
				status=0;
			}
			sql = "insert into helpboard(num, writer, subject, content, reg_date, status, ref, re_step, re_level) "
					+ "values(helpboard_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getSubject());
			pstmt.setString(3, article.getContent());
			pstmt.setTimestamp(4, article.getReg_date());
			pstmt.setInt(5, status); // status 값 설정
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	
	
	public int getArticleCount() throws Exception {
		int x=0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select count(*) from helpboard");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return x; 
	}

	public List getArticles(int start, int end)  {
		List articleList=null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement(	
					"select * from (select num,writer,subject,content,reg_date,ref,re_step,re_level,status,rownum r " +
					"from (select * from helpboard order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
			pstmt.setInt(1, start); 
			pstmt.setInt(2, end); 
			rs = pstmt.executeQuery();
			articleList = new ArrayList(end); 
			while(rs.next()){ 	
				HelpBoardDTO article = new HelpBoardDTO();	
			    article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setStatus(rs.getInt("status"));
				articleList.add(article); 	
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return articleList;
	}
	public HelpBoardDTO getArticle(int num) {
		HelpBoardDTO article=null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from helpboard where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {	
				article = new HelpBoardDTO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setStatus(rs.getInt("status"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		
		return article;
	}
	
	
	
	public HelpBoardDTO updateGetArticle(int num) {
		HelpBoardDTO article = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from helpboard where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				article = new HelpBoardDTO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setStatus(rs.getInt("status"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return article;
	}
	
	
	public void updateArticle(HelpBoardDTO article) {
		   try {
			  conn = OracleConnection.getConnection();
			  sql = "update  helpboard set subject=?,content=? where num=?";	
			  pstmt = conn.prepareStatement(sql);		
			  pstmt.setString(1, article.getSubject());
			  pstmt.setString(2, article.getContent());
			  pstmt.setInt(3, article.getNum());
			 pstmt.executeUpdate();  		// 그리고 업데이트 수정완료.
		
		   } catch (Exception e) {
			e.printStackTrace();	
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	   }
	
	
	  public int  helpDelete(int ref ) {	
			int result = 0;			// result 선언
			try {
			conn=OracleConnection.getConnection();
			sql="delete from helpboard where ref=?"; 
			pstmt = conn.prepareStatement(sql);	
			pstmt.setInt(1, ref);	
			result = pstmt.executeUpdate();	
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				OracleConnection.close(rs, pstmt, conn);
			}
			return result;
		}
	  
	  
	  
	  public List<HelpBoardDTO> getRepliesByRef(int ref, int num) {
	        List<HelpBoardDTO> replyList = new ArrayList<HelpBoardDTO>();
	        try {
	        	conn=OracleConnection.getConnection();
	             sql = "SELECT * FROM helpboard WHERE ref = ? AND num != ? ORDER BY re_step ASC, re_level ASC";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, ref);
	            pstmt.setInt(2, num);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                HelpBoardDTO reply = new HelpBoardDTO();
	                reply.setNum(rs.getInt("num"));
	                reply.setWriter(rs.getString("writer"));
	                reply.setSubject(rs.getString("subject"));
	                reply.setContent(rs.getString("content"));
	                reply.setReg_date(rs.getTimestamp("reg_date"));
	                reply.setRef(rs.getInt("ref"));
	                reply.setRe_step(rs.getInt("re_step"));
	                reply.setRe_level(rs.getInt("re_level"));
	                reply.setStatus(rs.getInt("status"));
	                replyList.add(reply);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	OracleConnection.close(rs, pstmt, conn);
	        }

	        return replyList;
	    }
	
	  
	  public List<HelpBoardDTO> getArticlesByWriter(int startRow, int endRow, String writer) {
	        List<HelpBoardDTO> articleList = new ArrayList<>();
	        try {
	         sql = "SELECT * FROM (SELECT ROWNUM rnum, num, writer, subject, reg_date, status, re_level FROM"
	        		+ " (SELECT num, writer, subject, reg_date, status, re_level FROM help_board WHERE writer = ? ORDER BY num DESC)) WHERE rnum >= ? AND rnum <= ?";
		        pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, writer);
	            pstmt.setInt(2, startRow);
	            pstmt.setInt(3, endRow);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	             HelpBoardDTO article = new HelpBoardDTO();
	             article.setNum(rs.getInt("num"));
	             article.setWriter(rs.getString("writer"));
	             article.setSubject(rs.getString("subject"));
	             article.setReg_date(rs.getTimestamp("reg_date"));
	             article.setStatus(rs.getInt("status"));
	             article.setRe_level(rs.getInt("re_level"));
	             articleList.add(article);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	OracleConnection.close(rs, pstmt, conn);
	         }
	        return articleList;
	    }
	
	  
	
  
}











