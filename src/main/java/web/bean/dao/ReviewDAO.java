package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import web.bean.dto.ReviewFileDTO;
import web.bean.dto.ReviewDTO;
import web.bean.dto.ReservationDTO;

public class ReviewDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
		
	public void reviewUpload(String rsvt_id) {
		try {
			conn = OracleConnection.getConnection();
			sql = "update reservation set review=1 where rsvt_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rsvt_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	
	public int getMyReviewCount(String id) {
		int x = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from review where writer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public int getReviewCount() {
		int x = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from review";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public List getMyReviewList(String id, int start, int end) {
		List myReviewList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from(select num, writer, subject, content, reg_date, star, rsvt_id from review "
					+ "where writer=? order by reg_date desc) where rownum >=? and rownum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			myReviewList = new ArrayList(end);
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStar(rs.getInt("star"));
				dto.setRsvt_id(rs.getString("rsvt_id"));
				myReviewList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return myReviewList;
	}
	
	public List getReviewList(int start, int end) {
		List reviewList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from (select num, writer, subject, content, reg_date, ref, re_step, re_level, star, rsvt_id, rownum r "
					+ "from (select * from review order by ref desc, re_step asc) order by ref desc, re_step asc) where r>= ? and r<= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			reviewList = new ArrayList(end);
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setStar(rs.getInt("star"));
				dto.setRsvt_id(rs.getString("rsvt_id"));
				reviewList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return reviewList;
	}
	
	public ReviewDTO getReview(int num) {
		ReviewDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from review where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ReviewDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setStar(rs.getInt("star"));
				dto.setRsvt_id(rs.getString("rsvt_id"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public int maxNum() {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select max(num) from review";
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
	
	public void insertReview(ReviewDTO dto) {
		int num = dto.getNum();
		int ref = dto.getRef();
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		int number=0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select max(num) from review"; //26
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();// rs=26
			if(rs.next()) {
				number=rs.getInt(1)+1; //27
			}else {
				number=1;
			}
			
			if(num!=0) {
				sql = "update review set re_step=re_step+1 where ref=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
			}else {
				ref=number;
				re_step=0;
				re_level=0;
			}
			sql = "insert into review(num, writer,subject, content, reg_date, ref, re_step, re_level, star, rsvt_id) "
					+ "values(review_seq.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setTimestamp(4, dto.getReg_date());
			pstmt.setInt(5,ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setInt(8, dto.getStar());
			pstmt.setString(9, dto.getRsvt_id());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	
	public void insertFile(ReviewFileDTO dto) {
		try {
			conn = OracleConnection.getConnection();
			sql = "insert into reviewfile values(reviewfile_seq.nextval, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getReview_num());
			pstmt.setString(2, dto.getFilename());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	
	public void updateFile(int count, int num) {
		try {
			conn = OracleConnection.getConnection();
			sql = "update review set reviewfile=? where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	
	public List getReviewImg(int num) {
		List reviewImg = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from reviewfile where review_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			reviewImg = new ArrayList();
			while(rs.next()) {
				ReviewFileDTO dto = new ReviewFileDTO();
				dto.setNum(rs.getInt("num"));
				dto.setReview_num(rs.getInt("review_num"));
				dto.setFilename(rs.getString("filename"));
				reviewImg.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return reviewImg;
	}
	
	public List<String> deleteReview(int num){
		List<String> fileNames = null;
		int reviewfile=0;
		int x = -1;
		try {
			conn = OracleConnection.getConnection();
			sql = "select reviewfile from review where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewfile = rs.getInt("reviewfile");
				pstmt = conn.prepareStatement("delete from review where num=?");
				pstmt.setInt(1, num);
				x = pstmt.executeUpdate();
				if(x==1) {
					if(reviewfile>0) {
						sql="select filename from reviewfile where review_num=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						fileNames=new ArrayList<>();
						while(rs.next()) {
							fileNames.add(rs.getString(1));
						}
						pstmt = conn.prepareStatement("delete from reviewfile where review_num=?");
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return fileNames;
	}
}
