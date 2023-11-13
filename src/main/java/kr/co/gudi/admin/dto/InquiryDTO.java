package kr.co.gudi.admin.dto;

import java.sql.Date;

public class InquiryDTO {
	
	private int inq_num;
	private String user_id; // member 테이블 user_id 
	private String inq_code;
	private String inq_subject;
	private Date inq_date;
	private String inq_content;
	private int inq_state;
	
	private Date inqhis_date;
	private String ad_id;
	private String inqhis_subject;
	private String inqhis_content;
	
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public String getInqhis_subject() {
		return inqhis_subject;
	}
	public void setInqhis_subject(String inqhis_subject) {
		this.inqhis_subject = inqhis_subject;
	}
	public String getInqhis_content() {
		return inqhis_content;
	}
	public void setInqhis_content(String inqhis_content) {
		this.inqhis_content = inqhis_content;
	}
	public Date getInqhis_date() {
		return inqhis_date;
	}
	public void setInqhis_date(Date inqhis_date) {
		this.inqhis_date = inqhis_date;
	}
	public int getInq_num() {
		return inq_num;
	}
	public void setInq_num(int inq_num) {
		this.inq_num = inq_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getInq_code() {
		return inq_code;
	}
	public void setInq_code(String inq_code) {
		this.inq_code = inq_code;
	}
	public String getInq_subject() {
		return inq_subject;
	}
	public void setInq_subject(String inq_subject) {
		this.inq_subject = inq_subject;
	}
	public Date getInq_date() {
		return inq_date;
	}
	public void setInq_date(Date inq_date) {
		this.inq_date = inq_date;
	}
	public String getInq_content() {
		return inq_content;
	}
	public void setInq_content(String inq_content) {
		this.inq_content = inq_content;
	}
	public int getInq_state() {
		return inq_state;
	}
	public void setInq_state(int inq_state) {
		this.inq_state = inq_state;
	}
	
	

}
