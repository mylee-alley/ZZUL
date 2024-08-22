package web.bean.dto;

import java.sql.Timestamp;

public class ReservationDTO {

	private String rsvt_id;			// 예약번호 != 사용자id
	private String rsvt_name;		// 예약자명
	private String rsvt_phon;		// 예약자전화번호
	private String rsvt_menu;		// 예약메뉴
	private String deposit;			// 예약금
	private Timestamp rsvt_date;	// 예약결제일자
	private int rsvt_status;		// 예약상태
	private int rsvt_head_count;	// 예약인원수
	private Timestamp visit_date;	// 예약방문날짜
	private String visit_time;		// 예약방문시간
	private int deposit_payby;		// 예약금결제방식
	private String user_id;			// 예약자id
	private String rsvt_cncl_reason; // 예약취소사유
	private int review;				// 예약취소상태

	private int num;
	private String menu;
	private int count;

	public String getRsvt_id() {
		return rsvt_id;
	}

	public void setRsvt_id(String rsvt_id) {
		this.rsvt_id = rsvt_id;
	}

	public String getRsvt_name() {
		return rsvt_name;
	}

	public void setRsvt_name(String rsvt_name) {
		this.rsvt_name = rsvt_name;
	}

	public String getRsvt_phon() {
		return rsvt_phon;
	}

	public void setRsvt_phon(String rsvt_phon) {
		this.rsvt_phon = rsvt_phon;
	}

	public String getRsvt_menu() {
		return rsvt_menu;
	}

	public void setRsvt_menu(String rsvt_menu) {
		this.rsvt_menu = rsvt_menu;
	}

	public String getDeposit() {
		return deposit;
	}

	public void setDeposit(String deposit) {
		this.deposit = deposit;
	}

	public Timestamp getRsvt_date() {
		return rsvt_date;
	}

	public void setRsvt_date(Timestamp rsvt_date) {
		this.rsvt_date = rsvt_date;
	}

	public int getRsvt_status() {
		return rsvt_status;
	}

	public void setRsvt_status(int rsvt_status) {
		this.rsvt_status = rsvt_status;
	}

	public int getRsvt_head_count() {
		return rsvt_head_count;
	}

	public void setRsvt_head_count(int rsvt_head_count) {
		this.rsvt_head_count = rsvt_head_count;
	}

	public Timestamp getVisit_date() {
		return visit_date;
	}

	public void setVisit_date(Timestamp visit_date) {
		this.visit_date = visit_date;
	}

	public String getVisit_time() {
		return visit_time;
	}

	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}

	public int getDeposit_payby() {
		return deposit_payby;
	}

	public void setDeposit_payby(int deposit_payby) {
		this.deposit_payby = deposit_payby;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getRsvt_cncl_reason() {
		return rsvt_cncl_reason;
	}

	public void setRsvt_cncl_reason(String rsvt_cncl_reason) {
		this.rsvt_cncl_reason = rsvt_cncl_reason;
	}

	public int getReview() {
		return review;
	}

	public void setReview(int review) {
		this.review = review;
	}
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "ReservationDTO [rsvt_id=" + rsvt_id + ", rsvt_name=" + rsvt_name + ", rsvt_phon=" + rsvt_phon
				+ ", rsvt_menu=" + rsvt_menu + ", deposit=" + deposit + ", rsvt_date=" + rsvt_date + ", rsvt_status="
				+ rsvt_status + ", rsvt_head_count=" + rsvt_head_count + ", visit_date=" + visit_date + ", visit_time="
				+ visit_time + ", deposit_payby=" + deposit_payby + ", user_id=" + user_id + ", rsvt_cncl_reason="
				+ rsvt_cncl_reason + ", review=" + review + ", num=" + num + ", menu=" + menu + ", count=" + count
				+ ", getRsvt_id()=" + getRsvt_id() + ", getRsvt_name()=" + getRsvt_name() + ", getRsvt_phon()="
				+ getRsvt_phon() + ", getRsvt_menu()=" + getRsvt_menu() + ", getDeposit()=" + getDeposit()
				+ ", getRsvt_date()=" + getRsvt_date() + ", getRsvt_status()=" + getRsvt_status()
				+ ", getRsvt_head_count()=" + getRsvt_head_count() + ", getVisit_date()=" + getVisit_date()
				+ ", getVisit_time()=" + getVisit_time() + ", getDeposit_payby()=" + getDeposit_payby()
				+ ", getUser_id()=" + getUser_id() + ", getRsvt_cncl_reason()=" + getRsvt_cncl_reason()
				+ ", getReview()=" + getReview() + ", getNum()=" + getNum() + ", getMenu()=" + getMenu()
				+ ", getCount()=" + getCount() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	
}