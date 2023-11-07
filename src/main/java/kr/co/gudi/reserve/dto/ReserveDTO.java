package kr.co.gudi.reserve.dto;

public class ReserveDTO {
	
	private int r_num;
	private String user_id;
	private String com_id;
	private int a_num;
	private String r_start;
	private String r_end;
	private String r_pick;
	private String r_pickaddr;
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
	private String a_name;	
	private String a_kind;
	private String a_spec;
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
