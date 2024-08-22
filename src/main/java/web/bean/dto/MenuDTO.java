package web.bean.dto;

public class MenuDTO {
   
   private int num ; //메뉴넘버
   private String name ; //메뉴이름
   private String detail ; // 메뉴 상세설명
   private String price ; // 메뉴 가격(10,000 천단위 컴마때매 스트링)
   private int count ; // 누적 예약회수 (인기메뉴)
   private int onoff ; //판매중지0_판매중1_삭제2
   private String img; // 메뉴 사진
   private String deposit; // 메뉴별 예약금
   
   //getter
   public int getNum() {return num;}
   public String getName() {return name;}
   public String getDetail() {return detail;}
   public String getPrice() {return price;}
   public int getCount() {return count;}
   public int getOnoff() {return onoff;}
   public String getImg() {return img;}
   public String getDeposit() {return deposit;}
   
   //setter
   public void setNum(int num) {this.num = num;}
   public void setName(String name) {this.name = name;}
   public void setDetail(String detail) {this.detail = detail;}
   public void setPrice(String price) {this.price = price;}
   public void setCount(int count) {this.count = count;}
   public void setOnoff(int onoff) {this.onoff = onoff;}
   public void setImg(String img) {this.img = img;}
   public void setDeposit(String deposit) {this.deposit = deposit;}
   
   
}