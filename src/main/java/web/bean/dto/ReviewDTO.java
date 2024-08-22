package web.bean.dto;

import java.sql.Timestamp;

public class ReviewDTO {
	private int num;
	private String writer;
	private String subject;
	private String content;
	private Timestamp reg_date;
	private int ref;
	private int re_step;
	private int re_level;
	private int star;
	private int reviewfile;
	private String rsvt_id;

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public int getReviewfile() {
		return reviewfile;
	}
	public void setReviewfile(int reviewfile) {
		this.reviewfile = reviewfile;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getRsvt_id() {
		return rsvt_id;
	}
	public void setRsvt_id(String rsvt_id) {
		this.rsvt_id = rsvt_id;
	}
	
}
