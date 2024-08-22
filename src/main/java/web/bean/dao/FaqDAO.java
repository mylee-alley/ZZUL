package web.bean.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.FaqDTO;
import web.bean.dto.NoticeDTO;

public class FaqDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	//faq테이블에 있는 모든 값 가져오기
	public List faqlist() {
		List faqList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from faq";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			faqList = new ArrayList();
			while(rs.next()) {
				FaqDTO dto = new FaqDTO();
				dto.setFaqNum(rs.getInt("faqNum"));
				dto.setQuestion(rs.getString("question"));
				dto.setAnswer(rs.getString("answer"));
				faqList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		} return faqList;
	}
	
	//faqNum값과 일치하는 레코드 가져오기
	
	public List sameNreco(int faqNum) {
		List sameNlist = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from faq where faqNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, faqNum);
			rs = pstmt.executeQuery();
			sameNlist = new ArrayList();
			while(rs.next()) {
				FaqDTO dto = new FaqDTO();
				dto.setFaqNum(rs.getInt("faqNum"));
				dto.setQuestion(rs.getString("question"));
				dto.setAnswer(rs.getString("answer"));
				sameNlist.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		} return sameNlist;
	}
	
	//faq 수정 메서드
		public int faqUpdate(FaqDTO dto) {
			 int result = 0 ;
			try {
				conn = OracleConnection.getConnection();
				sql = "update faq set question =?, answer=? where faqNum=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getQuestion());
				pstmt.setString(2, dto.getAnswer());
				pstmt.setInt(3, dto.getFaqNum());
				result=pstmt.executeUpdate(); // 1 행 이(가) 업데이트되었습니다.
				} catch (Exception e) {
				e.printStackTrace();
			}finally {
				OracleConnection.close(rs, pstmt, conn);
			} return result;
		}
		
		//faq 새글 등록
		public int faqAdd(FaqDTO dto) {
			int result = 0 ;
			try {
				conn = OracleConnection.getConnection();
				sql = "insert into faq values(faq_seq.nextval,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getQuestion());
				pstmt.setString(2, dto.getAnswer());
				result = pstmt.executeUpdate(); // 1행 추가되었습니다.				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				OracleConnection.close(rs, pstmt, conn);
			} return result;
		}
		
		//faq 글 삭제
		public int faqDel(int faqNum) {
			 int result = 0 ;
			try {
				conn = OracleConnection.getConnection();
				sql = "delete from faq where faqNum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, faqNum);
				result=pstmt.executeUpdate(); // 1 행 이(가) 삭제되었습니다.		
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				OracleConnection.close(rs, pstmt, conn);
				} return result;
			}

}
