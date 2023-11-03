package kr.co.gudi.location.dto;

public class LocationDTO {
	private String user_id;
	private String com_name;
	private String com_time;
	private int accept;
	private String pickup;
	private int user_total;
	private String address;
	private int avg_star;
	private double lat;
	private double lon;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCom_name() {
		return com_name;
	}
	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}
	public String getCom_time() {
		return com_time;
	}
	public void setCom_time(String com_time) {
		this.com_time = com_time;
	}
	public int getAccept() {
		return accept;
	}
	public void setAccept(int accept) {
		this.accept = accept;
	}
	public String getPickup() {
		return pickup;
	}
	public void setPickup(String pickup) {
		this.pickup = pickup;
	}
	public int getUser_total() {
		return user_total;
	}
	public void setUser_total(int user_total) {
		this.user_total = user_total;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getAvg_star() {
		return avg_star;
	}
	public void setAvg_star(int avg_star) {
		this.avg_star = avg_star;
	}
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
}
