package web.bean.dto;

public class FaqDTO {
	private int faqNum ; //faq 글번호
	private String question; // 자주묻는 질문 (제목)
	private String answer; // 답변 (글내용)
	
	//getter
	public int getFaqNum() {return faqNum;}
	public String getQuestion() {return question;}
	public String getAnswer() {return answer;}
	
	//setter
	public void setFaqNum(int faqNum) {this.faqNum = faqNum;}
	public void setQuestion(String question) {this.question = question;}
	public void setAnswer(String answer) {this.answer = answer;}


}
