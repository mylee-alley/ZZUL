package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.RsvtHelpDTO;

public class RsvtHelpDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;
	
	public List<RsvtHelpDTO> getHelps(int start , int end) {
			List<RsvtHelpDTO> helpList = null;
			try {
				conn = OracleConnection.getConnection();
				sql = "select * from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,boardfile,rownum r "
						+ "from (select * from RESERVATIONHELPBOARD order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				helpList = new ArrayList<RsvtHelpDTO>(end);
				while(rs.next()) {
					RsvtHelpDTO help = new RsvtHelpDTO();
					help.setNum(rs.getInt("num"));
					help.setWriter(rs.getString("writer"));
					help.setEmail(rs.getString("email"));
					help.setSubject(rs.getString("subject"));
					help.setPasswd(rs.getString("passwd"));
					help.setReg_date(rs.getTimestamp("reg_date"));
					help.setReadcount(rs.getInt("readcount"));
					help.setRef(rs.getInt("ref"));
					help.setRe_step(rs.getInt("re_step"));
					help.setRe_level(rs.getInt("re_level"));
					help.setContent(rs.getString("content"));
					help.setIp(rs.getString("ip"));
					help.setBoardfile(rs.getInt("boardfile"));
					helpList.add(help);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				OracleConnection.close(rs, pstmt, conn);
			}
			return helpList;
		}

	public int getHelpCount() throws Exception {
		int x = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from RESERVATIONHELPBOARD";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return x;
	}

	public int helpDelete(int num) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "delete from RESERVATIONHELPBOARD where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}

	public RsvtHelpDTO getHrlpSelect(int num) {
		RsvtHelpDTO hdto = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from RESERVATIONHELPBOARD where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				hdto = new RsvtHelpDTO();
				hdto.setNum(rs.getInt("num"));
				hdto.setWriter(rs.getString("writer"));
				hdto.setEmail(rs.getString("email"));
				hdto.setSubject(rs.getString("subject"));
				hdto.setPasswd(rs.getString("passwd"));
				hdto.setReg_date(rs.getTimestamp("reg_date"));
				hdto.setReadcount(rs.getInt("readcount"));
				hdto.setRef(rs.getInt("ref"));
				hdto.setRe_step(rs.getInt("re_step"));
				hdto.setRe_level(rs.getInt("re_level"));
				hdto.setContent(rs.getString("content"));
				hdto.setBoardfile(rs.getInt("boardfile"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return hdto;
	}

	public void inserthelp(RsvtHelpDTO hdto) {
		int num = hdto.getNum();
		int ref = hdto.getRef();
		int re_step = hdto.getRe_step();
		int re_level = hdto.getRe_level();
		int number = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select max(num) from RESERVATIONHELPBOARD";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			if (num != 0) {
				sql = "update RESERVATIONHELPBOARD set re_step = re_step+1 where ref=? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}

			sql = "insert into RESERVATIONHELPBOARD(num,writer,email,subject,passwd,reg_date,"
					+ "ref,re_step,re_level,content) values(help_seq.nextval,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, hdto.getWriter());
			pstmt.setString(2, hdto.getEmail());
			pstmt.setString(3, hdto.getSubject());
			pstmt.setString(4, hdto.getPasswd());
			pstmt.setTimestamp(5, hdto.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, hdto.getContent());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
}
