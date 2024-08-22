package web.bean.dto;
import java.sql.Timestamp;

public class NoticeDTO {

	private int notiNum; // 글번호
	private String title; //글제목
	private String content;//글내용
	private Timestamp reg_date;//작성일
	private String img; //첨부파일
	
	//getter
	public int getNotiNum() {return notiNum;}
	public String getTitle() {return title;}
	public String getContent() {return content;}
	public Timestamp getReg_date() {return reg_date;}
	public String getImg() {return img;}
	
	//setter
	public void setNotiNum(int notiNum) {this.notiNum = notiNum;}
	public void setTitle(String title) {this.title = title;}
	public void setContent(String content) {this.content = content;}
	public void setReg_date(Timestamp reg_date) {this.reg_date = reg_date;}
	public void setImg(String img) {this.img = img;}

}
