package kr.co.gudi.admin.dto;

import java.sql.Date;

public class AdBoardDTO {
	
	private String ad_id;
	private Date adb_date;
	private String adb_subject;
	private String adb_content;
	private int adb_hit;
	private String adb_state;
	private String b_code;
	
	private int b_num;
	
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public Date getAdb_date() {
		return adb_date;
	}
	public void setAdb_date(Date adb_date) {
		this.adb_date = adb_date;
	}
	public String getAdb_subject() {
		return adb_subject;
	}
	public void setAdb_subject(String adb_subject) {
		this.adb_subject = adb_subject;
	}
	public String getAdb_content() {
		return adb_content;
	}
	public void setAdb_content(String adb_content) {
		this.adb_content = adb_content;
	}
	public int getAdb_hit() {
		return adb_hit;
	}
	public void setAdb_hit(int adb_hit) {
		this.adb_hit = adb_hit;
	}
	public String getAdb_state() {
		return adb_state;
	}
	public void setAdb_state(String adb_state) {
		this.adb_state = adb_state;
	}
	public String getB_code() {
		return b_code;
	}
	public void setB_code(String b_code) {
		this.b_code = b_code;
	}
	

}
