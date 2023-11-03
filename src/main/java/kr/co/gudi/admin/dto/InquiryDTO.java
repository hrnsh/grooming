package kr.co.gudi.admin.dto;

import java.sql.Date;

public class InquiryDTO {
	
	private int note_num;
	private String receiver;
	private String sender;
	private Date note_date;
	private String note_subject;
	private String note_content;
	private String note_state;
	
	public int getNote_num() {
		return note_num;
	}
	public void setNote_num(int note_num) {
		this.note_num = note_num;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public Date getNote_date() {
		return note_date;
	}
	public void setNote_date(Date note_date) {
		this.note_date = note_date;
	}
	public String getNote_subject() {
		return note_subject;
	}
	public void setNote_subject(String note_subject) {
		this.note_subject = note_subject;
	}
	public String getNote_content() {
		return note_content;
	}
	public void setNote_content(String note_content) {
		this.note_content = note_content;
	}
	public String getNote_state() {
		return note_state;
	}
	public void setNote_state(String note_state) {
		this.note_state = note_state;
	}

	
}
