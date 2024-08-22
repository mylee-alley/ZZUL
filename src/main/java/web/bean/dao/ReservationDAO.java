package web.bean.dao;

import java.sql.*;
import java.util.*;

import web.bean.dto.MenuDTO;
import web.bean.dto.ReservationDTO;
import web.bean.dto.RsvtMenuDTO;

public class ReservationDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = null;

	public List<String> getMenuList(String rsvtId) {
		List<String> menuList = new ArrayList<>();
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from rsvt_menu where rsvt_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rsvtId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				menuList.add(rs.getString("menu"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return menuList;
	}

	public String getRsvtId(String name, String phone, Timestamp date) {
		System.out.println("ReservationDAO getRsvtId() name ::: " + name);
		System.out.println("ReservationDAO getRsvtId() phone ::: " + phone);
		String str = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement(
					"select rsvt_id from RESERVATION where rsvt_name=? and rsvt_phon=? and visit_date=?");
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			pstmt.setTimestamp(3, date);
//			pstmt.setString(4, time);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				str = rs.getString("rsvt_id");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}

		return str;
	}

	public ReservationDTO getOneReservation(String rsvtId) {
		ReservationDTO article = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from RESERVATION where rsvt_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rsvtId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new ReservationDTO();
				article.setRsvt_id(rs.getString("rsvt_id"));
				article.setRsvt_name(rs.getString("rsvt_name"));
				article.setRsvt_phon(rs.getString("rsvt_phon"));
				article.setRsvt_menu(rs.getString("rsvt_menu"));
				article.setDeposit(rs.getString("deposit"));
				article.setRsvt_date(rs.getTimestamp("rsvt_date"));
				article.setRsvt_status(rs.getInt("rsvt_status"));
				article.setRsvt_head_count(rs.getInt("rsvt_head_count"));
				article.setVisit_date(rs.getTimestamp("visit_date"));
				article.setDeposit_payby(rs.getInt("deposit_payby"));
				article.setUser_id(rs.getString("user_id"));
				article.setRsvt_cncl_reason(rs.getString("rsvt_cncl_reason"));
				article.setVisit_time(rs.getString("visit_time"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return article;
	}

	public ReservationDTO getArticle(String num) {
		ReservationDTO article = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("update RESERVATION set rsvt_status = rsvt_status-1 where rsvt_id = ?");
			pstmt.setString(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from RESERVATION where rsvt_id = ?");
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new ReservationDTO();
				article.setRsvt_id(rs.getString("rsvt_id"));
				article.setRsvt_name(rs.getString("rsvt_name"));
				article.setRsvt_phon(rs.getString("rsvt_phon"));
				article.setRsvt_menu(rs.getString("rsvt_menu"));
				article.setDeposit(rs.getString("deposit"));
				article.setRsvt_date(rs.getTimestamp("rsvt_date"));
				article.setRsvt_status(rs.getInt("rsvt_status"));
				article.setRsvt_head_count(rs.getInt("rsvt_head_count"));
				article.setRsvt_cncl_reason(rs.getString("rsvt_cncl_reason"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}

		return article;
	}

	public List<ReservationDTO> getReservation(String sid) {
		ReservationDTO rdto = null;
		List<ReservationDTO> list = null;
		list = new ArrayList<>();
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from reservation where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rdto = new ReservationDTO();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}

		return list;
	}

	public List<ReservationDTO> getReservationView(String name, String phon) {
		ReservationDTO rdto = null;
		List<ReservationDTO> list = null;
		list = new ArrayList<>();
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from reservation where rsvt_name=? and rsvt_phon= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phon);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				rdto = new ReservationDTO();
				rdto.setRsvt_id(rs.getString("rsvt_id"));
				rdto.setRsvt_name(rs.getString("rsvt_name"));
				rdto.setRsvt_menu(rs.getString("rsvt_menu"));
				rdto.setDeposit(rs.getString("deposit"));
				rdto.setRsvt_date(rs.getTimestamp("rsvt_date"));
				rdto.setRsvt_head_count(rs.getInt("rsvt_head_count"));
				rdto.setVisit_date(rs.getTimestamp("visit_date"));
				rdto.setVisit_time(rs.getString("visit_time"));
				rdto.setRsvt_status(rs.getInt("rsvt_status"));
				rdto.setVisit_time(rs.getString("visit_time"));
				list.add(rdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return list;
	}

	// 창희 사용자 로그인시 예약내역 조회
	public List<ReservationDTO> getArticle2(String num) {
		ReservationDTO article2 = null;
		List<ReservationDTO> list = new ArrayList<ReservationDTO>();

		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from reservation where user_id = ?");
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				article2 = new ReservationDTO();
				article2.setRsvt_id(rs.getString("rsvt_id"));
				article2.setRsvt_name(rs.getString("rsvt_name"));
				article2.setRsvt_phon(rs.getString("rsvt_phon"));
				article2.setRsvt_menu(rs.getString("rsvt_menu"));
				article2.setDeposit(rs.getString("deposit"));
				article2.setRsvt_date(rs.getTimestamp("rsvt_date"));
				article2.setVisit_date(rs.getTimestamp("visit_date"));
				article2.setVisit_time(rs.getString("visit_time"));
				article2.setRsvt_status(rs.getInt("rsvt_status"));
				article2.setRsvt_head_count(rs.getInt("rsvt_head_count"));
				article2.setRsvt_cncl_reason(rs.getString("rsvt_cncl_reason"));
				article2.setReview(rs.getInt("review"));
				list.add(article2);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}

		return list;
	}

//창희 사용자 로그인시 예약 취소
	public int updateArticle(String rid, String rcr) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			PreparedStatement pstmt = conn
					.prepareStatement("update reservation set rsvt_status = 0, rsvt_cncl_reason = ? where rsvt_id = ?");
			pstmt.setString(1, rcr);
			pstmt.setString(2, rid);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}

	public String bkInfo(ReservationDTO dto) { // 창희_ 마이페이지 예약내역&재확인창 메뉴불러오기
		String menu = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select name from menu where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRsvt_menu()); // num=? 이 숫자로 들어오기 떄문에 int로 사용
			rs = pstmt.executeQuery();
			if (rs.next()) {
				menu = rs.getString("name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return menu;
	}

	public int checkOverHead(String date, String time) {
		System.out.println("reservationDAO checkOverHead() date ::: " + date);
		System.out.println("reservationDAO checkOverHead() time ::: " + time);
		int head = 0;
		try {
			conn = OracleConnection.getConnection();
//			sql = "select sum(rsvt_head_count) as total_head_count from reservation "
//					+ "where visit_date=? and visit_time=?";
			
//			sql = "select rsvt_t1_head_max from mgrsvtdate where date_value =?";
			
			sql = "select sum(rsvt_head_count) as total_head_count from reservation "
					+ "where visit_date =? and visit_time = (select rsvt_t1 from mgrsvtdate where date_value =?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, time);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				head = rs.getInt("total_head_count");
				System.out.println("reservationDAO checkOverHead() head ::: " + head);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return head;
	}

	public void userBooking(ReservationDTO dto) {
		try {
			conn = OracleConnection.getConnection();
			sql = "insert into reservation(rsvt_id, rsvt_name, rsvt_phon, rsvt_menu, deposit, rsvt_date, rsvt_head_count, visit_date, user_id, visit_time)"
					+ "values(reservation_seq.nextVal, ?,?,?,?,sysdate,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRsvt_name());
			pstmt.setString(2, dto.getRsvt_phon());
			pstmt.setString(3, dto.getRsvt_menu());
//			pstmt.setString(4, dto.getDeposit());
			pstmt.setString(4, Integer.toString(dto.getRsvt_head_count() * 10000)); // 임시
			pstmt.setInt(5, dto.getRsvt_head_count());
			pstmt.setTimestamp(6, dto.getVisit_date());
			pstmt.setString(7, dto.getUser_id());
			pstmt.setString(8, dto.getVisit_time());
			pstmt.executeUpdate();

			pstmt.setString(1, dto.getUser_id());
			if (dto.getUser_id() != null) {
				sql = "update member set book_count=book_count+1,"
						+ " user_grade = case when book_count < 1 then 0 when book_count <= 9 then 1 else 2 end"
						+ "where id =?";
			} else {
				sql = "update MEMBER set book_count=book_count+1 where id=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}

	public void updateRsvtMenu(ReservationDTO dto) {
		System.out.println("ReservationDAO getRsvtMenu");
		try {
			conn = OracleConnection.getConnection();
			sql = "insert into RSVT_MENU(num, rsvt_id, menu, count) values(rsvt_menu_seq.nextVal, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRsvt_id());
			pstmt.setString(2, dto.getMenu());
			pstmt.setInt(3, dto.getCount());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}

	public List getOnMenu() {
		List menuList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from menu where onoff=1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			menuList = new ArrayList();
			while (rs.next()) {
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return menuList;
	}

	public List getUserRsvtMenu(String rsvtId) {
		System.out.println("ReservationDAO getUserRsvtMenu() rsvtId ::: " + rsvtId);
		List rsvtMenuList = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from RSVT_MENU where rsvt_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rsvtId);
			rs = pstmt.executeQuery();
			rsvtMenuList = new ArrayList();
			while (rs.next()) {
				ReservationDTO dto = new ReservationDTO();
				dto.setNum(rs.getInt("num"));
				dto.setRsvt_id(rs.getString("rsvt_id"));
				dto.setMenu(rs.getString("menu"));
				dto.setCount(rs.getInt("count"));
				rsvtMenuList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return rsvtMenuList;
	}

	public List<RsvtMenuDTO> getMenu(ReservationDTO dto) {
		List<RsvtMenuDTO> menu = new ArrayList<>();
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select menu , count , rsvt_id from rsvt_menu where rsvt_id = ?");
			pstmt.setString(1, dto.getRsvt_id());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				RsvtMenuDTO rmdto = new RsvtMenuDTO();
				rmdto.setMenu(rs.getString("menu"));
				rmdto.setRsvt_id(rs.getString("rsvt_id"));
				rmdto.setCount(rs.getInt("count"));
				menu.add(rmdto);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return menu;
	}

}