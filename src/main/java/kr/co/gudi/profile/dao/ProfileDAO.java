package kr.co.gudi.profile.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.gudi.profile.dto.ProfileDTO;

public interface ProfileDAO {

	ProfileDTO profile(String user_id);

	ArrayList<ProfileDTO> list(String user_id);

	int profileupdate(HashMap<String, String> params);

	ArrayList<ProfileDTO> updatelist(String user_id);

	int animalprofiledelete(String a_num);

	int animalregister(HashMap<String, String> params);

	int comregister(HashMap<String, String> params);

	ProfileDTO userstatechecker(String user_id);

	int userstateupdater(String user_id, String state);

	ArrayList<ProfileDTO> comlist(String user_id);

	int userstatedeleter(String user_id, String state);

	int writepickupinfo(String com_num, String p_distance, String p_section, String p_price);

	ArrayList<ProfileDTO> pickuplist(String com_num);

	int writeticketprice(String com_num, String t_price, String t_type);

	int pickuppricedelete(String p_num);

	ArrayList<ProfileDTO> ticketlist(String com_num);

	int ticketpricedelete(String t_num);

}
