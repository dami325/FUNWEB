package board;

import java.sql.Timestamp;






public class NoticeReplyDTO {
	private int num; // 댓글의 번호
	private String boardType; // 게시판 타입
	private int refNum; // 댓글의 원본 게시물 번호
	private String name; // 댓글 작성자(아이디)
	private String content; // 댓글 내용
	private Timestamp date; // 댓글 작성 일시
	
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public int getRefNum() {
		return refNum;
	}
	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
	
	

}
