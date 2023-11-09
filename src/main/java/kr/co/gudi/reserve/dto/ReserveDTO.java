package kr.co.gudi.reserve.dto;

import java.sql.Date;

public class ReserveDTO {
	
	private int rrep_num;
	private Date rrep_date;
	private String rrep_content;
	private String rrep_state;
	public int getRrep_num() {
		return rrep_num;
	}
	public void setRrep_num(int rrep_num) {
		this.rrep_num = rrep_num;
	}
	public Date getRrep_date() {
		return rrep_date;
	}
	public void setRrep_date(Date rrep_date) {
		this.rrep_date = rrep_date;
	}
	public String getRrep_content() {
		return rrep_content;
	}
	public void setRrep_content(String rrep_content) {
		this.rrep_content = rrep_content;
	}
	public String getRrep_state() {
		return rrep_state;
	}
	public void setRrep_state(String rrep_state) {
		this.rrep_state = rrep_state;
	}
	private int r_num;
	private String user_id;
	private String com_id;
	private String com_name;
	private String phone;
	private int a_num;
	private String a_name;	
	private int a_age;
	private String a_gender;
	public String getA_gender() {
		return a_gender;
	}
	public void setA_gender(String a_gender) {
		this.a_gender = a_gender;
	}
	private String a_kind;
	private String a_spec;
	private String r_start;
	private String r_end;
	private String r_pick;
	private String r_pickaddr;
	private String r_spec;
	private int rev_num;
	private String rev_subject;
	private int rev_star;
	private String rev_content;
	private Date rev_date;
	private String c_reason;
	private Date c_date;
	public String getC_reason() {
		return c_reason;
	}
	public void setC_reason(String c_reason) {
		this.c_reason = c_reason;
	}
	public Date getC_date() {
		return c_date;
	}
	public void setC_date(Date c_date) {
		this.c_date = c_date;
	}
	public int getRev_num() {
		return rev_num;
	}
	public void setRev_num(int rev_num) {
		this.rev_num = rev_num;
	}
	public String getRev_subject() {
		return rev_subject;
	}
	public void setRev_subject(String rev_subject) {
		this.rev_subject = rev_subject;
	}
	public int getRev_star() {
		return rev_star;
	}
	public void setRev_star(int rev_star) {
		this.rev_star = rev_star;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public Date getRev_date() {
		return rev_date;
	}
	public void setRev_date(Date rev_date) {
		this.rev_date = rev_date;
	}
	public String getRev_state() {
		return rev_state;
	}
	public void setRev_state(String rev_state) {
		this.rev_state = rev_state;
	}
	public String getRev_code() {
		return rev_code;
	}
	public void setRev_code(String rev_code) {
		this.rev_code = rev_code;
	}
	private String rev_state;
	private String rev_code;
	public String getCom_name() {
		return com_name;
	}
	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getA_age() {
		return a_age;
	}
	public void setA_age(int a_age) {
		this.a_age = a_age;
	}
	public String getR_spec() {
		return r_spec;
	}
	public void setR_spec(String r_spec) {
		this.r_spec = r_spec;
	}
	private String r_totalprice;
	private String r_state;
	private String t_type;
	private String t_price;
	public String getT_type() {
		return t_type;
	}
	public void setT_type(String t_type) {
		this.t_type = t_type;
	}
	public String getT_price() {
		return t_price;
	}
	public void setT_price(String t_price) {
		this.t_price = t_price;
	}
	private double lat;
	private double lon;
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public String getA_kind() {
		return a_kind;
	}
	public void setA_kind(String a_kind) {
		this.a_kind = a_kind;
	}
	public String getA_spec() {
		return a_spec;
	}
	public void setA_spec(String a_spec) {
		this.a_spec = a_spec;
	}
	public int getR_num() {
		return r_num;
	}
	public void setR_num(int r_num) {
		this.r_num = r_num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCom_id() {
		return com_id;
	}
	public void setCom_id(String com_id) {
		this.com_id = com_id;
	}
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	public String getR_start() {
		return r_start;
	}
	public void setR_start(String r_start) {
		this.r_start = r_start;
	}
	public String getR_end() {
		return r_end;
	}
	public void setR_end(String r_end) {
		this.r_end = r_end;
	}
	public String getR_pick() {
		return r_pick;
	}
	public void setR_pick(String r_pick) {
		this.r_pick = r_pick;
	}
	public String getR_pickaddr() {
		return r_pickaddr;
	}
	public void setR_pickaddr(String r_pickaddr) {
		this.r_pickaddr = r_pickaddr;
	}
	public String getR_totalprice() {
		return r_totalprice;
	}
	public void setR_totalprice(String r_totalprice) {
		this.r_totalprice = r_totalprice;
	}
	public String getR_state() {
		return r_state;
	}
	public void setR_state(String r_state) {
		this.r_state = r_state;
	}
	
	
}
