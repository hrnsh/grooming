package kr.co.gudi.admin.dto;

import java.sql.Date;

public class InquiryHistoryDTO {
	
	private int inqhis_num;
	private int inq_num;
	private String ad_id;
	private String inqhis_subject;
	private String inqhis_content;
	private Date inqhis_date;
	
	
	public int getInqhis_num() {
		return inqhis_num;
	}
	public void setInqhis_num(int inqhis_num) {
		this.inqhis_num = inqhis_num;
	}
	public int getInq_num() {
		return inq_num;
	}
	public void setInq_num(int inq_num) {
		this.inq_num = inq_num;
	}
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
	
	
	
}
