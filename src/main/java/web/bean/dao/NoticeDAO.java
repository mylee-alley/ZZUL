package web.bean.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.NoticeDTO;

public class NoticeDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	//페이지의 시작글부터 마지막글까지의 공지사항 레코드 등록일 내림차순으로 가져오기
	public List notilist(int startRow,int endRow) {
		List notiList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "SELECT * FROM (SELECT NOTINUM, TITLE, CONTENT, REG_DATE, ROWNUM AS rnum "
					+ "FROM (SELECT NOTINUM, TITLE, CONTENT, REG_DATE FROM notice ORDER BY REG_DATE DESC))"
					+ "WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			notiList= new ArrayList();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotiNum(rs.getInt("notiNum"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				notiList.add(dto);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		} return notiList;		
	}
	
	//notiNum과 일치하는 레코드 가져오기
	public List sameNotiNumR(int notinum) {
		List sameNumR = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from notice where notinum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notinum);
			rs = pstmt.executeQuery();
			sameNumR = new ArrayList();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotiNum(rs.getInt("notiNum"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setImg(rs.getString("img"));
				sameNumR.add(dto);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		} return sameNumR;		
	}
	
	//공지사항 새글만 추가
	public int notiAdd(NoticeDTO dto) {
		int result = 0 ;
		try {
			conn = OracleConnection.getConnection();
			sql = "insert into notice values(notice_seq.nextval,?,?,sysdate,'')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			result = pstmt.executeUpdate(); // 1행 추가되었습니다.				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		} return result;
	}
	
	//notiNum 제일 큰 값(사진추가시 들어갈 notiNum 값)
	public int maxNotiNum() {
			int result = 0;
			try {
				conn = OracleConnection.getConnection();
				sql = "select max(notinum) from notice";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				OracleConnection.close(rs, pstmt, conn);
			}
			return result;
		}
	
	
	//공지사항 새글쓰기 사진추가 메서드
	public int imgAdd(String img, int notiNum) {
		 int result = 0 ;
		try {
			conn = OracleConnection.getConnection();
			sql = "update notice set img = ? where notinum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img);
			pstmt.setInt(2, notiNum);
			result=pstmt.executeUpdate(); // 1 행 이(가) 업데이트되었습니다.		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		} return result;
	}


	//공지사항 삭제 메서드
	public int notiDel(int notinum) {
		 int result = 0 ;
		try {
			conn = OracleConnection.getConnection();
			sql = "delete from notice where notiNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notinum);
			result=pstmt.executeUpdate(); // 1 행 이(가) 삭제되었습니다.		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
			} return result;
		}
	
	//공지사항 수정 메서드
	public int notiChange(NoticeDTO dto) {
		 int result = 0 ;
		try {
			conn = OracleConnection.getConnection();
			sql = "update notice set title =?, content=? where notinum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNotiNum());
			result=pstmt.executeUpdate(); // 1 행 이(가) 업데이트되었습니다.		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		} return result;
	}
	
	//공지사항 글 갯수
	public int notiWrtCount() {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from notice";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);	
			}					
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		} return result;		
	}
}