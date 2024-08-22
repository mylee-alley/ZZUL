package web.bean.dto;

import java.sql.Timestamp;

public class MemberDTO {

	private String id;
	private String pw;
	private String name;
	private String phone;
	private String email;
	private Timestamp reg_date;// 가입일
	private int active;// 활성화여부(블랙리스트 관리)
	private int book_count;// 예약횟수
	private String auto;// 자동로그인
	private int user_grade;// 회원등급

	// setter
	public void setId(String id) {// 2< id.length <21
		if (id.length() > 2 && id.length() < 21) {
			this.id = id;
		}
	}

	public void setPw(String pw) {// 5< pw.length <21
		if (pw.length() > 5 && pw.length() < 21) {
			this.pw = pw;
		}
	}

	public void setName(String name) {// 1< name.length <11
		if (name.length() > 1 && name.length() < 11) {
			this.name = name;
		}
	}

	public void setPhone(String phone) {// 숫자만입력 & 11글자
		try {
			double phnumck = Double.parseDouble(phone);
			if (phone.length() == 11) {
				this.phone = phone;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void setEmail(String email) {// 네이버,다음,구글만됨
//		String[] epart = email.split("@");
//		boolean naver = epart[1].equals("naver.com");
//		boolean daum = epart[1].equals("daum.net");
//		boolean google = epart[1].equals("google.com");
//		if (naver || daum || google) {
			this.email = email;
//		}
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public void setBook_count(int book_count) {
		this.book_count = book_count;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}

	public void setUser_grade(int user_grade) {
		this.user_grade = user_grade;
	}

	// getter
	public String getId() {
		return id;
	}

	public String getPw() {
		return pw;
	}

	public String getName() {
		return name;
	}

	public String getPhone() {
		return phone;
	}

	public String getEmail() {
		return email;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public int getActive() {
		return active;
	}

	public int getBook_count() {
		return book_count;
	}

	public String getAuto() {
		return auto;
	}

	public int getUser_grade() {
		return user_grade;
	}

}