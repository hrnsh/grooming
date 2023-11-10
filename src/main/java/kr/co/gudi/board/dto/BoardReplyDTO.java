package kr.co.gudi.board.dto;

import java.sql.Date;

public class BoardReplyDTO {
	
	private int brep_num;
	private int b_num;
	private String user_id;
	private Date brep_date;
	private String brep_content;
	private String brep_state;
	
	public int getBrep_num() {
		return brep_num;
	}
	public void setBrep_num(int brep_num) {
		this.brep_num = brep_num;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Date getBrep_date() {
		return brep_date;
	}
	public void setBrep_date(Date brep_date) {
		this.brep_date = brep_date;
	}
	public String getBrep_content() {
		return brep_content;
	}
	public void setBrep_content(String brep_content) {
		this.brep_content = brep_content;
	}
	public String getBrep_state() {
		return brep_state;
	}
	public void setBrep_state(String brep_state) {
		this.brep_state = brep_state;
	}

}
