package kr.co.gudi.admin.dto;

import java.sql.Date;

public class ReportDTO {
	
	private int report_num;
	private String user_id;
	private String report_type;
	private int report_get;
	private Date report_date;
	private String report_content;
	private int report_state;
	
	private int reqhis_num;
	private Date rephis_date;
	private String rephis_content;
	private String ad_id;
	
	
	
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public int getReqhis_num() {
		return reqhis_num;
	}
	public void setReqhis_num(int reqhis_num) {
		this.reqhis_num = reqhis_num;
	}
	public Date getRephis_date() {
		return rephis_date;
	}
	public void setRephis_date(Date rephis_date) {
		this.rephis_date = rephis_date;
	}
	public String getRephis_content() {
		return rephis_content;
	}
	public void setRephis_content(String rephis_content) {
		this.rephis_content = rephis_content;
	}
	public int getReport_num() {
		return report_num;
	}
	public void setReport_num(int report_num) {
		this.report_num = report_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public int getReport_get() {
		return report_get;
	}
	public void setReport_get(int report_get) {
		this.report_get = report_get;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public int getReport_state() {
		return report_state;
	}
	public void setReport_state(int report_state) {
		this.report_state = report_state;
	}
	
	
	
}

