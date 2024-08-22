package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.MgRsvtDTO;
import web.bean.dto.ReservationDTO;

public class MgRsvtDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;

	public List rsvtDate() {
		List dateList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select date_value from MGRSVTDATE where date_value>=sysdate order by date_value";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			dateList = new ArrayList();
			while (rs.next()) {
				MgRsvtDTO dto = new MgRsvtDTO();
				dto.setDate_value(rs.getString("date_value"));
				dateList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return dateList;
	}

	// 특정일자 예약 세부정보 조회
	public MgRsvtDTO getRsvtDay(String date) {
		System.out.println("MgRsvtDAO getRsvtDay() date ::: " + date);
		MgRsvtDTO result = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from MGRSVTDATE where date_value=?";
			
			
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = new MgRsvtDTO();
				result.setDate_value(rs.getString("date_value"));
				result.setRsvt_psblty_yn(rs.getString("rsvt_psblty_yn"));
				result.setMg_head_count_max(rs.getInt("mg_head_count_max"));
				result.setMg_head_count_min(rs.getInt("mg_head_count_min"));
				result.setExplain(rs.getString("explain"));
				result.setRsvt_t1(rs.getString("rsvt_t1"));
				result.setRsvt_t1_head_max(rs.getInt("rsvt_t1_head_max"));
				result.setRsvt_t2(rs.getString("rsvt_t2"));
				result.setRsvt_t2_head_max(rs.getInt("rsvt_t2_head_max"));
				result.setRsvt_t3(rs.getString("rsvt_t3"));
				result.setRsvt_t3_head_max(rs.getInt("rsvt_t3_head_max"));
				result.setRsvt_t4(rs.getString("rsvt_t4"));
				result.setRsvt_t4_head_max(rs.getInt("rsvt_t4_head_max"));
				result.setRsvt_t5(rs.getString("rsvt_t5"));
				result.setRsvt_t5_head_max(rs.getInt("rsvt_t5_head_max"));
				result.setDeposit(rs.getString("deposit"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}

	// 관리자 예약 건수 조회 (MGRSVTDATE테이블이 아닌 RESERVATION테이블임)
	public int getRsvtListCount(String divis) throws Exception {
		int x = 0;
		String sqldivis = "";
		if (divis.equals("today")) {
			sqldivis = " where visit_date = to_char(sysdate, 'YYYY/MM/DD') ";
		} else if (divis.equals("cancel")) {
			sqldivis = " where rsvt_status=0";
		}
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from RESERVATION" + sqldivis;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return x;
	}

	// 예약 목록 조회 (MGRSVTDATE테이블이 아닌 RESERVATION테이블임)
	public List getRsvtList(int start, int end, String divis) {
		System.out.println("MgRsvtDAO getRsvtList divis ::: " + divis);
		List rsvtList = null;
		String sqldivis = "";
		try {
			conn = OracleConnection.getConnection();
			if (divis.equals("all")) {
				sqldivis = "  ";
			} else if (divis.equals("today")) {
				sqldivis = " where visit_date = to_char(sysdate, 'YYYY/MM/DD') ";
			} else if (divis.equals("cancel")) {
				sqldivis = " where rsvt_status=0";
			}
			sql = "select * from (select rsvt_id, rsvt_name, rsvt_phon, rsvt_menu, "
					+ "deposit, rsvt_date, rsvt_status, rsvt_head_count, visit_date, deposit_payby, user_id, rownum r "
					+ "from (select * from RESERVATION " + sqldivis
					+ "ORDER BY visit_date DESC) ORDER BY visit_date DESC ) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			rsvtList = new ArrayList();
			while (rs.next()) {
				ReservationDTO rsvt = new ReservationDTO();
				rsvt.setRsvt_id(rs.getString("rsvt_id"));
				rsvt.setRsvt_name(rs.getString("rsvt_name"));
				rsvt.setRsvt_phon(rs.getString("rsvt_phon"));
				rsvt.setRsvt_menu(rs.getString("rsvt_menu"));
				rsvt.setDeposit(rs.getString("deposit"));
				rsvt.setRsvt_date(rs.getTimestamp("rsvt_date"));
				rsvt.setRsvt_status(rs.getInt("rsvt_status"));
				rsvt.setRsvt_head_count(rs.getInt("rsvt_head_count"));
				rsvt.setVisit_date(rs.getTimestamp("visit_date"));
				rsvt.setDeposit_payby(rs.getInt("deposit_payby"));
				rsvt.setUser_id(rs.getString("user_id"));
				rsvtList.add(rsvt);
			}
			System.out.println(rsvtList.size());
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return rsvtList;
	}

	// 관리자 일별영업세부설정 수정
	// DATE_VALUE 오늘부터? 내일부터?
	public int updateMgRsvtDate(MgRsvtDTO dto) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "update MGRSVTDATE set rsvt_psblty_yn=?, mg_head_count_max=?, mg_head_count_min=?"
					+ ", explain=?, rsvt_t1=?, rsvt_t1_head_max=?, rsvt_t2=?, rsvt_t2_head_max=?, rsvt_t3=?"
					+ ", rsvt_t3_head_max=?, rsvt_t4=?, rsvt_t4_head_max=?, rsvt_t5=?, rsvt_t5_head_max=?"
					+ " where date_value=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRsvt_psblty_yn());
			pstmt.setInt(2, dto.getMg_head_count_max());
			pstmt.setInt(3, dto.getMg_head_count_min());
			pstmt.setString(4, dto.getExplain());
			pstmt.setString(5, dto.getRsvt_t1());
			pstmt.setInt(6, dto.getRsvt_t1_head_max());
			pstmt.setString(7, dto.getRsvt_t2());
			pstmt.setInt(8, dto.getRsvt_t2_head_max());
			pstmt.setString(9, dto.getRsvt_t3());
			pstmt.setInt(10, dto.getRsvt_t3_head_max());
			pstmt.setString(11, dto.getRsvt_t4());
			pstmt.setInt(12, dto.getRsvt_t4_head_max());
			pstmt.setString(13, dto.getRsvt_t5());
			pstmt.setInt(14, dto.getRsvt_t5_head_max());
			pstmt.setString(15, dto.getDate_value());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}

	// 관리자 전체기간 영업세부설정목록 건수 출력
	public int getMgRsvtDateListCount() {
		int x = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from MGRSVTDATE";
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

	// 관리자 전체기간 영업세부설정목록 출력
	public List getMgRsvtDateList(int start, int end) {
		List mgdateList = null;
		try {
			conn = OracleConnection.getConnection();
//			sql = "select * from MGRSVTDATE order by date_value asc";
			sql = "SELECT * FROM (SELECT DATE_VALUE, RSVT_PSBLTY_YN, MG_HEAD_COUNT_MAX, MG_HEAD_COUNT_MIN, "
					+ "EXPLAIN, RSVT_T1, RSVT_T1_HEAD_MAX, RSVT_T2, RSVT_T2_HEAD_MAX, RSVT_T3, RSVT_T3_HEAD_MAX, "
					+ "RSVT_T4, RSVT_T4_HEAD_MAX, RSVT_T5, RSVT_T5_HEAD_MAX, DEPOSIT, "
					+ "rownum r from (select * from MGRSVTDATE WHERE DATE_VALUE>SYSDATE ORDER BY DATE_VALUE ASC) "
					+ "ORDER BY DATE_VALUE ASC ) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			mgdateList = new ArrayList();
			while (rs.next()) {
				MgRsvtDTO mgRsvt = new MgRsvtDTO();
				mgRsvt.setDate_value(rs.getString("date_value"));
				mgRsvt.setRsvt_psblty_yn(rs.getString("rsvt_psblty_yn"));
				mgRsvt.setMg_head_count_max(rs.getInt("mg_head_count_max"));
				mgRsvt.setMg_head_count_min(rs.getInt("mg_head_count_min"));
				mgRsvt.setExplain(rs.getString("explain"));
				mgRsvt.setRsvt_t1(rs.getString("rsvt_t1"));
				mgRsvt.setRsvt_t1_head_max(rs.getInt("rsvt_t1_head_max"));
				mgRsvt.setRsvt_t2(rs.getString("rsvt_t2"));
				mgRsvt.setRsvt_t2_head_max(rs.getInt("rsvt_t2_head_max"));
				mgRsvt.setRsvt_t3(rs.getString("rsvt_t3"));
				mgRsvt.setRsvt_t3_head_max(rs.getInt("rsvt_t3_head_max"));
				mgRsvt.setRsvt_t4(rs.getString("rsvt_t4"));
				mgRsvt.setRsvt_t4_head_max(rs.getInt("rsvt_t4_head_max"));
				mgRsvt.setRsvt_t5(rs.getString("rsvt_t5"));
				mgRsvt.setRsvt_t5_head_max(rs.getInt("rsvt_t5_head_max"));
				mgRsvt.setDeposit(rs.getString("deposit"));
				mgdateList.add(mgRsvt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return mgdateList;
	}

}
